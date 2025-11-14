import pynvim

from my.goto import goto_ex_at_cursor
from my.goto import goto_file_at_cursor
from my.markdown import add_ref_link as md_add_ref_link
from my.markdown import generate_ref_targets_map
from my.create import add_note_ref_link
from my.create import edit_note
from my.config import load_config
from my.uri import URI


@pynvim.plugin
class MyPlugin(object):
    def __init__(self, vim: pynvim.Nvim):
        self._vim = vim
        load_config(vim)

    # @pynvim.command(name='MyGenMdBufRefMap', sync=True)
    # def _cmd_gen_md_buf_ref_map(self):
    #     generate_ref_targets_map(self._vim.current.buffer)

    @pynvim.command(name="MyGoToFile", nargs="*", sync=True)
    def _cmd_go_to_file(self, args):
        if args:
            pass
        else:
            goto_file_at_cursor(self._vim)

    @pynvim.command(name="MyGoToEx", nargs="*", sync=True)
    def _cmd_go_to_ex(self, args):
        if args:
            pass
        else:
            goto_ex_at_cursor(self._vim)

    @pynvim.command(name="MyEditNote", nargs="*", sync=True)
    def _cmd_edit_note(self, args):
        edit_note(self._vim, args)

    @pynvim.command(name="MyAddNoteRefLink", nargs="*", sync=True)
    def _cmd_add_note_ref_link(self, args):
        add_note_ref_link(self._vim, args)

    @pynvim.command(name="MyAddClipboardRefLink", nargs="*", sync=True)
    def _cmd_add_clipboard_ref_link(self, args):
        md_add_ref_link(self._vim, " ".join(args), self._vim.eval("@+"))
