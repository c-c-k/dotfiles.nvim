from copy import deepcopy
import re

import pynvim

from my.globals import config
from my.path import resolve_path_with_context
from my.exceptions import NotebookError
from my.utils import AttrDict

_DEFAULT_NOTEBOOK = {
    "name": "default",
    "path": "~/notebooks/default_notebook",
    "use_path_as_root": True,
    "notes_path": "/notes",
    "extension": ".md",
    "filename_template": "%s-${TITLE_CLEAN}${EXTENSION}",
    "templates_path": "/templates",
    "default_template": "/templates/note.tpl",
}
_CONTEXTED_PATH_KEYS = ["notes_path", "templates_path", "default_template"]
_PATTERN_VALID_NOTEBOOK_NAME = re.compile(r"[a-z0-9_]+")


def load_config(vim: pynvim.Nvim):
    config.clear()

    config.notebook_prefix = vim.vars.get("my_notebook_prefix", "nb-")
    _load_notebooks_config(vim)

    return config


def _load_nb_config(raw_notebook: dict) -> AttrDict:
    notebook = AttrDict(deepcopy(_DEFAULT_NOTEBOOK))
    notebook.update(raw_notebook)

    notebook._id = get_nb_id(notebook)

    notebook_path = resolve_path_with_context(notebook.path, real=True)
    notebook.path = notebook_path

    # NOTE: `use_path_as_root` is disabled because it makes it problematic to
    #       supply out-of-notebook paths.
    # if notebook.use_path_as_root:
    #     context_pwd = None
    #     context_root = notebook_path
    # else:
    #     context_pwd = notebook_path
    #     context_root = None

    for key in _CONTEXTED_PATH_KEYS:
        notebook[key] = resolve_path_with_context(
            notebook[key],
            context_pwd=notebook_path,
            # context_pwd=context_pwd,
            # context_root=context_root,
            real=True,
        )

    return notebook


def set_active_nb_id(nb_name: str):
    notebooks = config.notebooks
    active_nb_id = None

    if nb_name in notebooks.keys():
        active_nb_id = nb_name
    else:
        for notebook in notebooks.values():
            if notebook.name == nb_name:
                active_nb_id = notebook._id
                break

    if active_nb_id is None:
        raise NotebookError(f"notebook not found: {nb_name}")

    config.active_nb_id = active_nb_id


def get_nb_id(notebook: AttrDict) -> str:
    if "_id" in notebook.keys():
        return notebook._id

    nb_name = notebook.name
    if not _PATTERN_VALID_NOTEBOOK_NAME.match(nb_name):
        raise NotebookError(
            f"Invalid notebook name '{nb_name}', notebook name must match '[a-z0-9_]+'"
        )

    return config.notebook_prefix + nb_name


def _load_notebooks_config(vim: pynvim.Nvim):
    notebooks_list = vim.vars.get("my_notebooks", [])

    if notebooks_list != []:
        notebooks = {
            notebook._id: notebook
            for notebook in (
                _load_nb_config(raw_notebook) for raw_notebook in notebooks_list
            )
        }
        active_nb_name = notebooks_list[0]["name"]
    else:
        default_notebook = _load_nb_config({})
        notebooks = {default_notebook._id: default_notebook}
        active_nb_name = default_notebook["name"]

    config.notebooks = AttrDict(notebooks)
    set_active_nb_id(active_nb_name)
