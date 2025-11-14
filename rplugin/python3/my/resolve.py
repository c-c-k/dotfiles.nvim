from importlib import import_module

import pynvim

from my.notebook import get_current_notebook
from my.globals import config
from my.path import resolve_path_with_context
from my.path import validate_path
from my.uri import URI

_DEFAULT_RESOLVER_PROTOCOLS: list[str] = ["file", "local", ""]


def _default_resolver(uri: URI, context_pwd: str | None) -> str | None:
    if uri.protocol in _DEFAULT_RESOLVER_PROTOCOLS:
        path = resolve_path_with_context(uri.body, context_pwd)
        return validate_path(path)
    return None


def _try_resolve(
    vim: pynvim.Nvim, resolver: str, uri: URI, context_pwd: str | None
) -> str | None:
    resolver_module_name, resolver_function_name = resolver.rsplit(".", maxsplit=1)
    resolver_module = import_module(resolver_module_name)
    resolver_function = getattr(resolver_module, resolver_function_name)
    return resolver_function(vim, uri, context_pwd)


def resolve_uri_as_notebook_path(
    vim: pynvim.Nvim, uri: URI, context_pwd: str | None = None
) -> str | None:
    if (uri.protocol != "") and (uri.protocol not in config.notebooks.keys()):
        return None

    if uri.protocol == "":
        notebook = get_current_notebook(vim, check_cb=True)
    else:
        notebook = config.notebooks[uri.protocol]

    nb_notes_path = notebook.notes_path
    path_str = resolve_path_with_context(
        uri.body, context_pwd=context_pwd, context_root=nb_notes_path
    )

    return validate_path(path_str)


def resolve_uri_as_path(
    vim: pynvim.Nvim, uri: URI, context_pwd: str | None = None
) -> str | None:
    path = None
    path = resolve_uri_as_notebook_path(vim, uri, context_pwd)
    # uri_resolvers = vim.vars.get("my_uri_resolvers", [])
    # for resolver in uri_resolvers:
    #     path = _try_resolve(vim, resolver, uri, context_pwd)
    #     if path is not None:
    #         break
    if path is None:
        path = _default_resolver(uri, context_pwd)
    return path
