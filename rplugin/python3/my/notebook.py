import os
from pathlib import Path

import pynvim

from my.globals import config
from my.path import resolve_path_with_context
from my.exceptions import NotebookError
from my.utils import AttrDict
from my.utils import get_auto_id


def get_notebook_auto_id(nb_id: str) -> str:
    notebook = get_notebook_by_nb_id(nb_id)
    nb_path = Path(notebook.path)
    id_file_path = nb_path.joinpath(".my_nb/next_id")
    return get_auto_id(id_file_path)


def get_notebook_by_nb_id(nb_id: str) -> AttrDict:
    notebook = config.notebooks.get(nb_id)
    if notebook is None:
        raise NotebookError(f"Non-existent notebook id: {nb_id}")

    return notebook


def get_nb_id_by_path(path_str: str) -> str | None:
    for notebook in config.notebooks.values():
        nb_path = notebook.path
        if path_str.startswith(nb_path):
            nb_id = notebook._id
            break
    else:
        nb_id = None

    return nb_id


def get_notebook_by_path(path_str: str) -> AttrDict | None:
    nb_id = get_nb_id_by_path(path_str)
    notebook = get_notebook_by_nb_id(nb_id) if nb_id is not None else None

    return notebook


def get_current_nb_id(vim: pynvim.Nvim, check_cb=False, check_pwd=False) -> str:
    nb_id = None

    if check_cb:
        buffer = vim.current.buffer
        path_str = resolve_path_with_context(buffer.name, real=True)
        nb_id = get_nb_id_by_path(path_str)

    if (nb_id is None) and check_pwd:
        path_str = os.getcwd()
        nb_id = get_nb_id_by_path(path_str)

    if nb_id is None:
        nb_id = config.active_nb_id

    return nb_id


def get_current_notebook(vim: pynvim.Nvim, check_cb=False, check_pwd=False) -> AttrDict:
    nb_id = get_current_nb_id(vim, check_cb, check_pwd)
    notebook = get_notebook_by_nb_id(nb_id)

    return notebook
