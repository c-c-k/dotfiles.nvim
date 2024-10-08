from datetime import datetime
import os.path as osp
from pathlib import Path
import re
import string
import typing as t

import pynvim

from cck.buffer import NBBuffer
from cck.globals import config
from cck.markdown import add_ref_link as md_add_ref_link
from cck.path import get_context_pwd
from cck.path import resolve_path_with_context
from cck.path import touch_with_mkdir
from cck.exceptions import NotebookError
from cck.notebook import get_nb_id_by_path
from cck.notebook import get_notebook_by_nb_id
from cck.notebook import get_current_nb_id
from cck.utils import get_dir_auto_id
from cck.uri import URI
from cck.utils import AttrDict

_TITLE_LEGAL_CHARACTERS = string.ascii_lowercase + string.digits + "._"
_TAG_LEGAL_CHARACTERS = string.ascii_lowercase + string.digits + "-"
_PATTERN_TAGS_LINE = re.compile(r"^[<>!-\\#/* \t]*@tags: *(?P<TAGS>.*)$")
_PATTERN_TITLE_LINE = re.compile(r"^#(?P<TITLE>[^#].*)$")
_TEMP_PROJECT_CARD_TEMPLATE = '${AUTO_ID}-${TITLE_CLEAN}'
_TEMP_PATTERN_IS_PROJECT_CARD = re.compile(r"^.*/projects/.*/cards/?$")
_TEMP_PATTERN_IS_CARD_ATTACHMENT = re.compile(r"^.*/projects/.*/cards/\w+/?$")
_PLACEHOLDER_FILENAME = "--PLACEHOLDER-FILENAME--"
_PLACEHOLDER_CONTENT_TEMPLATE = ""
_PLACEHOLDER_TAGS = ""


class NoteInfo:
    base_filename: str
    content_template_path: str
    extension: str
    filename: str
    filename_template: str
    path_str: str
    path_uri: URI
    tags: list[str]
    title: str
    _nb_id: str
    _dir_path_str: str
    _title_words: list[str]
    _use_cb: bool
    _use_dir_path_as_tags: bool
    _use_tags: bool
    _vim: pynvim.Nvim

    def __init__(self, vim: pynvim.Nvim, title_args: list[str], use_cb: bool):
        # Init private properties
        self._title_args = title_args
        self._use_cb = use_cb
        self._use_dir_path_as_tags = True
        self._vim = vim

        # Init public properties
        self.content_template_path = _PLACEHOLDER_CONTENT_TEMPLATE
        self.filename_template = _PLACEHOLDER_FILENAME
        self.tags = []
        self.use_tags = True

        # Execute other initialization logic
        self._parse_uri_arg()
        self._resolve_notebook()
        self._extract_extension()
        self._resolve_dir_path()
        self._resolve_extension()
        self._resolve_filename_template()
        self._resolve_content_template()
        self._adjust_card_attachment_note()
        self._adjust_card_note()
        self._create_title()
        self._create_filename()
        self._create_path_str()
        self._create_path_uri()
        self._add_dir_path_tags()

    @property
    def notebook(self) -> AttrDict:
        return get_notebook_by_nb_id(self._nb_id)

    def _parse_uri_arg(self):
        if len(self._title_args) == 0:
            self._nb_id = ""
            self._dir_path_str = ""
            return

        uri = URI(self._title_args[0])
        nb_id = uri.protocol
        dir_path_str = uri.body

        if (nb_id != "") and (nb_id not in config.notebooks):
            raise NotebookError(f"not a notebook: {nb_id}")
        if (nb_id == "") and ("/" not in dir_path_str):
            dir_path_str = ""
        if (dir_path_str != "") or (nb_id != ""):
            self._title_args = self._title_args[1:]
        if (nb_id != "") and (dir_path_str == ""):
            dir_path_str = "/"

        self._nb_id = nb_id
        self._dir_path_str = dir_path_str

    def _extract_extension(self):
        if (  # yapf hack
                (len(self._title_args) > 0)
                and (self._title_args[-1].find(".") == 0)):
            self.extension = self._title_args.pop()
        else:
            self.extension = ""

    def _resolve_notebook(self):
        if self._nb_id == "":
            self._nb_id = get_current_nb_id(self._vim, check_cb=self._use_cb)

    def _resolve_dir_path(self):
        nb_notes_path = self.notebook.notes_path

        if self._use_cb:
            buffer = self._vim.current.buffer
            buf_dir = get_context_pwd(buffer=buffer)
            buf_nb_id = (
                    get_nb_id_by_path(buf_dir) if buf_dir is not None else None
            )
            context_pwd = (
                    buf_dir if buf_nb_id == self._nb_id else nb_notes_path
            )
        else:
            context_pwd = nb_notes_path

        self._dir_path_str = resolve_path_with_context(
                self._dir_path_str,
                context_pwd=context_pwd,
                context_root=nb_notes_path
        )

    def _resolve_extension(self):
        if self.extension == "":
            self.extension = self.notebook.extension
        self.extension = _clean_title(self.extension.lstrip("."))

    def _resolve_filename_template(self):
        self.filename_template = self.notebook.filename_template

    def _resolve_content_template(self):
        self.content_template_path = self.notebook.default_template

    def _adjust_card_attachment_note(self):
        if _TEMP_PATTERN_IS_CARD_ATTACHMENT.match(self._dir_path_str):
            self.extension = ".".join(("attachment", self.extension))
            self._use_dir_path_as_tags = False
            self.use_tags = False

    def _adjust_card_note(self):
        if _TEMP_PATTERN_IS_PROJECT_CARD.match(self._dir_path_str):
            card_id = get_dir_auto_id(self._dir_path_str)
            self._dir_path_str = osp.join(self._dir_path_str, card_id)
            self.extension = ".".join(("card", self.extension))

    def _create_title(self):
        self.title = " ".join(self._title_args)

    def _create_filename(self):
        template_str = self.filename_template

        template_str = datetime.strftime(datetime.now(), template_str)
        template = string.Template(template_str)

        use_auto_id = "${AUTO_ID}" in template_str
        params = self._create_filename_params(use_auto_id=use_auto_id)
        self.base_filename = template.substitute(params)
        self.filename = ".".join((self.base_filename, self.extension))

    def _create_path_str(self):
        self.path_str = resolve_path_with_context(
                self.filename, context_pwd=self._dir_path_str
        )

    def _create_filename_params(self, use_auto_id: bool) -> dict[str, str]:
        params = {}
        params["TITLE_CLEAN"] = _clean_title(self.title)
        if use_auto_id:
            # params["AUTO_ID"] = get_notebook_auto_id(self._nb_id)
            params["AUTO_ID"] = get_dir_auto_id(self._dir_path_str)

        return params

    def _add_dir_path_tags(self):
        if not self._use_dir_path_as_tags:
            return

        tags = []

        id_dir = osp.dirname(self.id_)
        while id_dir != "/":
            tags.append(_clean_tag(osp.basename(id_dir)))
            id_dir = osp.dirname(id_dir)
        tags.reverse()

        parent_dir_name = osp.basename(osp.dirname(self.path_str))
        if parent_dir_name == self.base_filename:
            tags.append("index")

        self.tags.extend(tags)

    def _create_path_uri(self):
        prefix = osp.commonpath((self.notebook.notes_path, self.path_str))
        path_str = self.path_str[len(prefix):]
        self.path_uri = URI(self._nb_id, path_str)

    @property
    def id_(self) -> str:
        return self.path_uri.body


def _clean_tag(name: str) -> str:
    return _clean_string(
            name=name,
            valid_chars=_TAG_LEGAL_CHARACTERS,
            filler_char="-",
            preprocessor=lambda s: s.lower()
    )


def _clean_title(name: str) -> str:
    return _clean_string(
            name=name,
            valid_chars=_TITLE_LEGAL_CHARACTERS,
            filler_char="_",
            preprocessor=lambda s: s.lower()
    )


def _clean_string(
        name: str, valid_chars: str, filler_char: str,
        preprocessor: t.Callable | None
) -> str:
    if preprocessor is not None:
        name = preprocessor(name)

    last_char = ""
    cleaned_chars = []
    for char in name:
        cleaned_char = char if char in valid_chars else filler_char
        if not (cleaned_char == filler_char and last_char == filler_char):
            cleaned_chars.append(cleaned_char)
            last_char = cleaned_char

    return "".join(cleaned_chars).strip(filler_char)


def create_note(
        vim: pynvim.Nvim,
        title_args: list[str],
        use_cb: bool,
) -> NoteInfo | None:
    try:
        note_info = NoteInfo(vim, title_args, use_cb)
    except NotebookError as err:
        vim.api.echo([err.args], True, {})
        return None

    if osp.exists(note_info.path_str):
        return note_info
    if touch_with_mkdir(note_info.path_str) is None:
        vim.api.echo([[f"can not create file {note_info.path_str}"]], True, {})
        return None

    initial_content = _create_initial_content(vim, note_info, use_cb)
    Path(note_info.path_str).write_text(initial_content)

    return note_info


def _create_initial_content(
        vim: pynvim.Nvim, note_info: NoteInfo, use_cb: bool, **kwargs
) -> str:
    template_path = note_info.content_template_path
    if osp.exists(template_path):
        with open(template_path) as f:
            template_str = f.read()
    else:
        template_str = ""
    template = string.Template(template_str)
    params = _create_initial_content_params(vim, note_info, use_cb, **kwargs)
    initial_content = template.safe_substitute(params)
    return initial_content


def _create_initial_content_params(
        vim: pynvim.Nvim, note_info: NoteInfo, use_cb: bool, **kwargs
) -> dict[str, str]:
    params: dict[str, str] = {}

    # if use_cb:
    #     # copy initial params from current buffer
    #     nb_buffer = NBBuffer(vim)
    #     params["TITLE"] = (
    #             note_info.title if note_info.title != "" else
    #             nb_buffer.re(PATTERN_TITLE_LINE).group("TITLE")
    #     )
    #     params["TAGS"] = nb_buffer.re(PATTERN_TAGS_LINE).group("TAGS")
    # else:
    #     params["TITLE"] = note_info.title
    #     params["TAGS"] = ""

    params["TITLE"] = note_info.title
    params["TAGS"] = ", ".join(note_info.tags) if note_info.use_tags else ""
    params["TITLE_UPPER"] = params["TITLE"].upper()
    params["NOTE_ID"] = note_info.id_

    params.update(kwargs)
    return params


def edit_note(vim: pynvim.Nvim, title_args: list[str]):
    note_info = create_note(vim, title_args, use_cb=True)
    if note_info is None:
        vim.api.echo([["can not create/edit note from args: "],
                      [" ".join(title_args)]], True, {})
        return

    command = f"edit {note_info.path_str}"
    vim.command(command)


def add_note_ref_link(vim: pynvim.Nvim, title_args: list[str]):
    note_info = create_note(vim, title_args, use_cb=True)
    nb_buffer = NBBuffer(vim)
    if note_info is None:
        vim.api.echo([["can not create/find note from args: "], title_args],
                     True, {})
        return

    buffer_nb_id = get_nb_id_by_path(
            resolve_path_with_context(nb_buffer.buffer.name)
    )
    if note_info._nb_id == buffer_nb_id:
        link_target = note_info.path_uri.body
    else:
        link_target = str(note_info.path_uri)
    # md_add_ref_link(nb_buffer, note_info.title, link_target)
    md_add_ref_link(vim, note_info.title, link_target)
