# Notes and memos about the keymaps

- Exchanged `` ` `` (goto mark position) and `'` (goto mark line)
  because I find the former to be more often needed
  and the latter to be easier to press.
- Changed `[p`, `[P`, `]p` and `]P` to be in line with the `p` and `P` logic
  because trying to press `]p` often resulted
  in accidentally pressing `[p` or `\p` instead.
- Changed `[t` and `]t` to go to previous/next test instead of tab navigation
  due to adding an entirely different set of mappings for tab navigation.
- Set `gf` and `gx` to directly call custom function because I think it would
  be easier to manage than playing around with all of the related options.
- Set `gg` to go to first character in the buffer because it's usually whay I
  need and setting `'startofline'` to `"on"` also affects other situations.
- Set `H`, `J`, `K` and `L` to remaps of their lower case counterparts but
  with "in wrap" movement for `J` and `K` because of too often accidentally
  pressing them due to shift-lock.
  - This is also convenient to preserve consistencey in contexts like
    a file manager where `h` and `l` are convenient to remap
    to go into/out-of a directory while `H` and `L` can still be used
    to move inline when modifying a filename.
  - Their usual behavior is remapped to `<A-H>`, `<A-J>`, `<A-K>` and `<A-L>`.
- Remaped `s` and `S` because their vanilla mappings are somewhat redundant
  with a bit of practice (`cl` and `cc` are not really harder to press).
  - Originally replaced them with "Surround" and "Speed motion" mappings
    but that conflicted with the `s` mapping for staging in *Fugitive*.
  - Consequentially set them to *Git* stage and move the to previous/next hunk
    in normal buffers as well.
- Switched `<C-R>` and `U` because the former is more often needed
  while the latter is easier to press.
- Dedicated `<TAB>` and `<S-TAB>` to snippet navigation because mixing them
  with completion often resulted in incorrect behavior due to an completion
  triggering when I actually wanted to go to the nest snippet position.
- Similarly avoided using `<ENTER>` for completion because it often
  triggered completion when I actually wanted to start a new line.
- Set `i_CTRL-B` as a replacement for `i_CTRL-K`
  because it is unused by default and right next to `i_CTRL-V`
  while is `i_CTRL-K` for completion and thus has the above mentioned problem
  of often triggering completion when it is not wanted.
- Set `<SPACE>:`, `<SPACE>/` and `<SPACE>/` as replacements for `q:`, `q?`
  and `q/` because `q` is remapped to close stuff in some contexts
  and `<LEADER>:/?` is more convenient to press.
