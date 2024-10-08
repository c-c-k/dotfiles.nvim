import re
from typing import Pattern

import pynvim
from pynvim.api import Buffer

_VALID_PATH_PATTERN: Pattern = re.compile(r"^[\w./-]+$")


class NBBufferRe:
    _buffer: Buffer
    _last_match: re.Match | None
    _last_match_line_num: int | None
    _last_pattern: Pattern | str | None

    def __init__(self, buffer: Buffer):
        self._buffer = buffer
        self._last_match = None
        self._last_match_line_num = None
        self._last_pattern = None

    def _do_search(self, pattern: Pattern | str | None):
        if pattern is None:
            return

        self._last_pattern = pattern

        buffer = self._buffer
        for line, linenum in zip(buffer, range(len(buffer))):
            match_ = re.search(pattern, line)
            if match_ is not None:
                self._last_match = match_
                self._last_match_line_num = linenum
                break
        else:
            self._last_match = None
            self._last_match_line_num = None

    def group(self, group_selector, default: str = "") -> str:
        try:
            group_ = self._last_match.group(group_selector)  # type: ignore
        except (AttributeError, IndexError):
            group_ = None
        return group_ if group_ is not None else default

    def line_num(self, default: int | None = None) -> int | None:
        lml_num = self._last_match_line_num
        return lml_num if lml_num is not None else default


class NBBuffer:
    _buffer: Buffer
    _re: NBBufferRe

    def __init__(self, vim: pynvim.Nvim, buffer: Buffer | None = None):
        self._vim = vim
        self._buffer = buffer if buffer is not None else vim.current.buffer
        self._re = NBBufferRe(self._buffer)

    @property
    def buffer(self) -> Buffer:
        return self._buffer

    @property
    def vim(self) -> pynvim.Nvim:
        return self._vim

    def re(self, pattern: Pattern | str | None = None) -> NBBufferRe:
        self._re._do_search(pattern)
        return self._re
