from enum import auto
from enum import Enum

import pynvim

from cck.handle import handle_uri
from cck.resolve import resolve_uri_as_path
from cck.markdown import get_uri_at_cursor
from cck.path import get_context_pwd
from cck.path import touch_with_mkdir
from cck.uri import URI


class _GotoMethod(Enum):
    EDIT = auto()
    EX = auto()


def _edit_file_at_uri(vim: pynvim.Nvim, uri: URI, context_pwd: str | None):
    path_str = resolve_uri_as_path(vim, uri, context_pwd=context_pwd)
    if path_str is None:
        vim.api.echo([[f"'{uri!s}' not found"]], True, {})
        return
    path_str = touch_with_mkdir(path_str)
    if path_str is None:
        vim.api.echo([[
                f"'can't create {uri!s}'",
        ]], True, {})
        return
    command = f"edit {path_str}"
    vim.command(command)


def _ex_uri(vim: pynvim.Nvim, uri: URI, context_pwd: str | None):
    # .. important: This function is in a place holder state, properly it
    #               should delegate the URI interpretation logic to the handler
    #               function.

    if uri.protocol in {"", "file", "local"}:
        path_str = resolve_uri_as_path(vim, uri, context_pwd=context_pwd)
        if path_str is not None:
            uri.body = path_str
            uri.protocol = ""
    else:
        # The logic here is meant to potentially deal with a nested URI
        # like e.g. "print:nb-notes:/note_to_print"
        nested_uri = URI(uri.body)
        if nested_uri.protocol != "":
            path_str = resolve_uri_as_path(vim, nested_uri, context_pwd)
            if path_str is not None:
                uri.body = path_str
        else:
            # .. note: In retrospect I'm not sure what the logic here was meant
            #           to do, for the moment I'm leaving it in place so as to
            #           review it again when I refactor this function to
            #           delegate URI handling to the handler function.
            pass
            # path_str = resolve_uri_as_path(vim, uri, context_pwd)
            # if path_str is None:
            #     path_str = resolve_uri_as_path(vim, nested_uri, context_pwd)

    handle_uri(vim, uri)


def _open_nvim_help(vim: pynvim.Nvim, help_topic: str):
    # Open the help and capture window details
    vim.command(f'help {help_topic}')
    help_winid = vim.current.window.number
    help_bufnr = vim.current.buffer.number
    # Switch to the previous window and open the help there
    vim.command('wincmd p')
    vim.current.buffer = help_bufnr
    # Close the split help window
    vim.command(f'{help_winid}wincmd c')


def _goto_uri(vim: pynvim.Nvim, goto_method: _GotoMethod):
    uri_string = get_uri_at_cursor(vim)
    if uri_string is None:
        vim.api.echo([["No URI/file under cursor"]], True, {})
        return

    uri = URI(uri_string)

    if uri.protocol == "vimhelp":
        _open_nvim_help(vim, uri.body)
    # raise Exception(str((uri, str(type(uri)))))
    context_dir = get_context_pwd()

    if goto_method is _GotoMethod.EX:
        _ex_uri(vim, uri, context_dir)
    else:
        _edit_file_at_uri(vim, uri, context_dir)


def goto_file_at_cursor(vim: pynvim.Nvim):
    _goto_uri(vim, goto_method=_GotoMethod.EDIT)


def goto_ex_at_cursor(vim: pynvim.Nvim):
    _goto_uri(vim, goto_method=_GotoMethod.EX)
