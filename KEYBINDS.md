# Keybindings

Generated from the live keymap table on 2026-08-07. Leader is `<Space>`.

Only mappings that carry a real description are listed; `<Plug>` internals and
mini.pairs auto-pairing keys are omitted. Buffer-local mappings (LSP `gd`/`gr`,
filetype-specific keys) exist only while a matching buffer is open, so they are
not all captured here - press `<Space>` and let which-key show what applies now.

Modes: `n` normal, `i` insert, `v` visual+select, `x` visual, `o` operator-pending, `t` terminal.

Regenerate after changing keymaps: see the note at the bottom of this file.

## Leader groups

### `<leader>b` - Buffers

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>bb` | n | Switch to Other Buffer |
| `<leader>bd` | n | Delete Buffer |
| `<leader>bD` | n | Delete Buffer and Window |
| `<leader>bi` | n | Delete Invisible Buffers |
| `<leader>bj` | n | Pick Buffer |
| `<leader>bl` | n | Delete Buffers to the Left |
| `<leader>bo` | n | Delete Other Buffers |
| `<leader>bp` | n | Toggle Pin |
| `<leader>bP` | n | Delete Non-Pinned Buffers |
| `<leader>br` | n | Delete Buffers to the Right |

### `<leader>c` - Code and LSP

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>cd` | n | Line Diagnostics |
| `<leader>cf` | n v x | Format |
| `<leader>cF` | n v x | Format Injected Langs |
| `<leader>cm` | n | Mason |
| `<leader>cn` | n | Generate Annotations (Neogen) |
| `<leader>cs` | n | Aerial (Symbols) |
| `<leader>cS` | n | LSP references/definitions/... (Trouble) |

### `<leader>d` - Debug (DAP)

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>da` | n | Run with Args |
| `<leader>db` | n | Toggle Breakpoint |
| `<leader>dB` | n | Breakpoint Condition |
| `<leader>dc` | n | Run/Continue |
| `<leader>dC` | n | Run to Cursor |
| `<leader>de` | n v x | Eval |
| `<leader>dg` | n | Go to Line (No Execute) |
| `<leader>di` | n | Step Into |
| `<leader>dj` | n | Down |
| `<leader>dk` | n | Up |
| `<leader>dl` | n | Run Last |
| `<leader>do` | n | Step Out |
| `<leader>dO` | n | Step Over |
| `<leader>dP` | n | Pause |
| `<leader>dph` | n | Toggle Profiler Highlights |
| `<leader>dpp` | n | Toggle Profiler |
| `<leader>dps` | n | Profiler Scratch Buffer |
| `<leader>dr` | n | Toggle REPL |
| `<leader>ds` | n | Session |
| `<leader>dt` | n | Terminate |
| `<leader>du` | n | Dap UI |
| `<leader>dw` | n | Widgets |

### `<leader>D` - Database (dadbod)

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>D` | n | Toggle DBUI |

### `<leader>e` - Explorer

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>e` | n | Explorer Snacks (root dir) |

### `<leader>E` - Explorer (cwd)

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>E` | n | Explorer Snacks (cwd) |

### `<leader>f` - Find and files

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>fb` | n | Buffers |
| `<leader>fB` | n | Buffers (all) |
| `<leader>fc` | n | Find Config File |
| `<leader>fe` | n | Explorer Snacks (root dir) |
| `<leader>fE` | n | Explorer Snacks (cwd) |
| `<leader>ff` | n | Find Files (Root Dir) |
| `<leader>fF` | n | Find Files (cwd) |
| `<leader>fg` | n | Find Files (git-files) |
| `<leader>fn` | n | New File |
| `<leader>fp` | n | Projects |
| `<leader>fr` | n | Recent |
| `<leader>fR` | n | Recent (cwd) |
| `<leader>ft` | n | Terminal (Root Dir) |
| `<leader>fT` | n | Terminal (cwd) |

### `<leader>g` - Git

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>gb` | n | Git Blame Line |
| `<leader>gB` | n v x | Git Browse (open) |
| `<leader>gd` | n | [G]it [D]iff |
| `<leader>gD` | n | Git Diff (origin) |
| `<leader>gf` | n | Git Current File History |
| `<leader>gg` | n | Lazygit (Root Dir) |
| `<leader>gG` | n | Lazygit (cwd) |
| `<leader>gh` | n | Git Diff (hunks) |
| `<leader>gI` | n | Search Issues (Octo) |
| `<leader>gi` | n | List Issues (Octo) |
| `<leader>gl` | n | Git Log |
| `<leader>gL` | n | Git Log (cwd) |
| `<leader>gp` | n | List PRs (Octo) |
| `<leader>gP` | n | Search PRs (Octo) |
| `<leader>gr` | n | List Repos (Octo) |
| `<leader>gs` | n | Git Status |
| `<leader>gS` | n | Search (Octo) |
| `<leader>gY` | n v x | Git Browse (copy) |

### `<leader>h` - Git hunks

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>h` | n | Harpoon Quick Menu |

### `<leader>H` - Harpoon

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>H` | n | Harpoon File |

### `<leader>l` - Lazy

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>l` | n | Lazy |

### `<leader>L` - LazyVim

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>L` | n | LazyVim Changelog |

### `<leader>n` - Notifications

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>n` | n | Notification History |

### `<leader>o` - Overseer (tasks)

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>oo` | n | Run task |
| `<leader>ot` | n | Task action |
| `<leader>ow` | n | Task list |

### `<leader>q` - Quit and sessions

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>qd` | n | Don't Save Current Session |
| `<leader>ql` | n | Restore Last Session |
| `<leader>qq` | n | Quit All |
| `<leader>qs` | n | Restore Session |
| `<leader>qS` | n | Select Session |

### `<leader>r` - Refactor

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>r` | n v x | +refactor |
| `<leader>rc` | n | Debug Cleanup |
| `<leader>rf` | n v x | Extract Function |
| `<leader>rF` | n v x | Extract Function To File |
| `<leader>ri` | n v x | Inline Variable |
| `<leader>rp` | n v x | Debug Print Variable |
| `<leader>rP` | n | Debug Print Location |
| `<leader>rs` | n v x | Select Refactor |
| `<leader>rx` | n v x | Extract Variable |

### `<leader>R` - REST client

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>R` | n | +Rest |
| `<leader>Rb` | n | Open scratchpad |
| `<leader>Rr` | n | Replay the last request |

### `<leader>s` - Search

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>s"` | n | Registers |
| `<leader>s/` | n | Search History |
| `<leader>sa` | n | Autocmds |
| `<leader>sb` | n | Buffer Lines |
| `<leader>sB` | n | Grep Open Buffers |
| `<leader>sc` | n | Command History |
| `<leader>sC` | n | Commands |
| `<leader>sd` | n | Diagnostics |
| `<leader>sD` | n | Buffer Diagnostics |
| `<leader>sg` | n | Grep (Root Dir) |
| `<leader>sG` | n | Grep (cwd) |
| `<leader>sh` | n | Help Pages |
| `<leader>sH` | n | Highlights |
| `<leader>si` | n | Icons |
| `<leader>sj` | n | Jumps |
| `<leader>sk` | n | Keymaps |
| `<leader>sl` | n | Location List |
| `<leader>sm` | n | Marks |
| `<leader>sM` | n | Man Pages |
| `<leader>sn` | n | +noice |
| `<leader>sna` | n | Noice All |
| `<leader>snd` | n | Dismiss All |
| `<leader>snh` | n | Noice History |
| `<leader>snl` | n | Noice Last Message |
| `<leader>snt` | n | Noice Picker (Telescope/FzfLua) |
| `<leader>sp` | n | Search for Plugin Spec |
| `<leader>sq` | n | Quickfix List |
| `<leader>sr` | n v x | Search and Replace |
| `<leader>sR` | n | Resume |
| `<leader>st` | n | Todo |
| `<leader>sT` | n | Todo/Fix/Fixme |
| `<leader>su` | n | Undotree |
| `<leader>sw` | n v x | Visual selection or word (Root Dir) |
| `<leader>sW` | n v x | Visual selection or word (cwd) |

### `<leader>S` - Surround / scratch

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>S` | n | Select Scratch Buffer |
| `<leader>Sa` | n v x | Add Surrounding |
| `<leader>Sd` | n | Delete Surrounding |
| `<leader>Sf` | n | Find Right Surrounding |
| `<leader>SF` | n | Find Left Surrounding |
| `<leader>Sh` | n | Highlight Surrounding |
| `<leader>Sn` | n | Update `MiniSurround.config.n_lines` |
| `<leader>Sr` | n | Replace Surrounding |

### `<leader>t` - Test

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>t` | n | +test |
| `<leader>ta` | n | Attach to Test (Neotest) |
| `<leader>td` | n | Debug Nearest |
| `<leader>tl` | n | Run Last (Neotest) |
| `<leader>to` | n | Show Output (Neotest) |
| `<leader>tO` | n | Toggle Output Panel (Neotest) |
| `<leader>tr` | n | Run Nearest (Neotest) |
| `<leader>ts` | n | Toggle Summary (Neotest) |
| `<leader>tS` | n | Stop (Neotest) |
| `<leader>tt` | n | Run File (Neotest) |
| `<leader>tT` | n | Run All Test Files (Neotest) |
| `<leader>tw` | n | Toggle Watch (Neotest) |

### `<leader>u` - UI toggles

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>ua` | n | Toggle Animations |
| `<leader>uA` | n | Toggle Tabline |
| `<leader>ub` | n | Toggle Dark Background |
| `<leader>uc` | n | Toggle Conceal Level |
| `<leader>uC` | n | Colorschemes |
| `<leader>ud` | n | Toggle Diagnostics |
| `<leader>uD` | n | Toggle Dimming |
| `<leader>uf` | n | Toggle Auto Format (Global) |
| `<leader>uF` | n | Toggle Auto Format (Buffer) |
| `<leader>ug` | n | Toggle Indent Guides |
| `<leader>uh` | n | Toggle Inlay Hints |
| `<leader>uI` | n | Inspect Tree |
| `<leader>ui` | n | Inspect Pos |
| `<leader>ul` | n | Toggle Line Numbers |
| `<leader>uL` | n | Toggle Relative Number |
| `<leader>un` | n | Dismiss All Notifications |
| `<leader>up` | n | Toggle Mini Pairs |
| `<leader>ur` | n | Redraw / Clear hlsearch / Diff Update |
| `<leader>us` | n | Toggle Spelling |
| `<leader>uS` | n | Toggle Smooth Scroll |
| `<leader>uT` | n | Toggle Treesitter Highlight |
| `<leader>uw` | n | Toggle Wrap |
| `<leader>uz` | n | Toggle Zen Mode |
| `<leader>uZ` | n | Toggle Zoom Mode |

### `<leader>w` - Windows

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>wd` | n | Delete Window |
| `<leader>wm` | n | Toggle Zoom Mode |

### `<leader>x` - Diagnostics and lists

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>xl` | n | Location List |
| `<leader>xL` | n | Location List (Trouble) |
| `<leader>xq` | n | Quickfix List |
| `<leader>xQ` | n | Quickfix List (Trouble) |
| `<leader>xt` | n | Todo (Trouble) |
| `<leader>xT` | n | Todo/Fix/Fixme (Trouble) |
| `<leader>xx` | n | Diagnostics (Trouble) |
| `<leader>xX` | n | Buffer Diagnostics (Trouble) |

### `<leader>K` - Keywordprg

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>K` | n | Keywordprg |

### `<leader>1` .. `<leader>9` - Harpoon slots

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>1` | n | Harpoon to File 1 |
| `<leader>2` | n | Harpoon to File 2 |
| `<leader>3` | n | Harpoon to File 3 |
| `<leader>4` | n | Harpoon to File 4 |
| `<leader>5` | n | Harpoon to File 5 |
| `<leader>6` | n | Harpoon to File 6 |
| `<leader>7` | n | Harpoon to File 7 |
| `<leader>8` | n | Harpoon to File 8 |
| `<leader>9` | n | Harpoon to File 9 |

### Other leader keys

| Key | Modes | Action |
| --- | --- | --- |
| `<leader> ` | n | Find Files (Root Dir) |
| `<leader>-` | n | Split Window Below |
| `<leader>,` | n | Buffers |
| `<leader>:` | n | Command History |
| `<leader>?` | n | Buffer Keymaps (which-key) |
| `<leader>.` | n | Toggle Scratch Buffer |
| `<leader>/` | n | Grep (Root Dir) |
| `<leader>`` | n | Switch to Other Buffer |
| `<leader><Tab>[` | n | Previous Tab |
| `<leader><Tab>]` | n | Next Tab |
| `<leader><Tab><Tab>` | n | New Tab |
| `<leader><Tab>d` | n | Close Tab |
| `<leader><Tab>f` | n | First Tab |
| `<leader><Tab>l` | n | Last Tab |
| `<leader><Tab>o` | n | Close Other Tabs |
| `<leader>\|` | n | Split Window Right |

## Non-leader keys

| Key | Modes | Action |
| --- | --- | --- |
| `[ ` | n | Add empty line above cursor |
| `[[` | n | Prev Reference |
| `[<C-L>` | n | :lpfile |
| `[<C-Q>` | n | :cpfile |
| `[<C-T>` | n | :ptprevious |
| `[a` | n | :previous |
| `[A` | n | :rewind |
| `[b` | n | Prev Buffer |
| `[B` | n | Move buffer prev |
| `[d` | n | Prev Diagnostic |
| `[D` | n | Jump to the first diagnostic in the current buffer |
| `[e` | n | Prev Error |
| `[L` | n | :lrewind |
| `[l` | n | :lprevious |
| `[n` | v x | Select previous node |
| `[N` | v x | Select previous sibling node |
| `[q` | n | Previous Trouble/Quickfix Item |
| `[Q` | n | :crewind |
| `[t` | n | Previous Todo Comment |
| `[T` | n | :trewind |
| `[w` | n | Prev Warning |
| `] ` | n | Add empty line below cursor |
| `]]` | n | Next Reference |
| `]<C-L>` | n | :lnfile |
| `]<C-Q>` | n | :cnfile |
| `]<C-T>` | n | :ptnext |
| `]A` | n | :last |
| `]a` | n | :next |
| `]b` | n | Next Buffer |
| `]B` | n | Move buffer next |
| `]d` | n | Next Diagnostic |
| `]D` | n | Jump to the last diagnostic in the current buffer |
| `]e` | n | Next Error |
| `]l` | n | :lnext |
| `]L` | n | :llast |
| `]n` | v x | Select next node |
| `]N` | v x | Select next sibling node |
| `]q` | n | Next Trouble/Quickfix Item |
| `]Q` | n | :clast |
| `]T` | n | :tlast |
| `]t` | n | Next Todo Comment |
| `]w` | n | Next Warning |
| `@` | v x | :help v_@-default |
| `*` | v x | :help v_star-default |
| `&` | n | :help &-default |
| `#` | v x | :help v_#-default |
| `<BS>` | i | MiniPairs <BS> |
| `<C-_>` | n t | which_key_ignore |
| `<C-/>` | n t | Terminal (Root Dir) |
| `<C-A>` | n v x | Increment |
| `<C-B>` | i n v | Scroll Backward |
| `<C-Down>` | n | Decrease Window Height |
| `<C-F>` | i n v | Scroll Forward |
| `<C-H>` | n | Go to Left Window |
| `<C-J>` | n | Go to Lower Window |
| `<C-K>` | n | Go to Upper Window |
| `<C-L>` | n | Go to Right Window |
| `<C-Left>` | n | Decrease Window Width |
| `<C-Right>` | n | Increase Window Width |
| `<C-S>` | i n v x | Save File |
| `<C-Space>` | n o v x | Treesitter Incremental Selection |
| `<C-U>` | i | :help i_CTRL-U-default |
| `<C-Up>` | n | Increase Window Height |
| `<C-W>` | i | :help i_CTRL-W-default |
| `<C-W> ` | n | Window Hydra Mode (which-key) |
| `<C-W><C-D>` | n | Show diagnostics under the cursor |
| `<C-W>d` | n | Show diagnostics under the cursor |
| `<C-X>` | n v x | Decrement |
| `<CR>` | i | MiniPairs <CR> |
| `<Down>` | n v x | Down |
| `<Esc>` | i n v | Escape and Clear hlsearch |
| `<M-j>` | i n v x | Move Down |
| `<M-k>` | i n v x | Move Up |
| `<S-Tab>` | i v | vim.snippet.jump if active, otherwise <S-Tab> |
| `<Tab>` | i v | vim.snippet.jump if active, otherwise <Tab> |
| `<Up>` | n v x | Up |
| `a` | o v x | Around textobject |
| `al` | o v x | Around last textobject |
| `an` | o v x | Around next textobject |
| `g[` | n o v x | Move to left "around" |
| `g]` | n o v x | Move to right "around" |
| `g<C-A>` | n v x | Increment |
| `g<C-X>` | n v x | Decrement |
| `gc` | o | Comment textobject |
| `gc` | n v x | Toggle comment |
| `gcc` | n | Toggle comment line |
| `gco` | n | Add Comment Below |
| `gcO` | n | Add Comment Above |
| `gO` | n | vim.lsp.buf.document_symbol() |
| `gra` | n v x | vim.lsp.buf.code_action() |
| `gri` | n | vim.lsp.buf.implementation() |
| `grn` | n | vim.lsp.buf.rename() |
| `grr` | n | vim.lsp.buf.references() |
| `grt` | n | vim.lsp.buf.type_definition() |
| `grx` | n | vim.lsp.codelens.run() |
| `gx` | n v x | Opens filepath or URI under cursor with the system handler (file explorer, web browser, …) |
| `H` | n | Prev Buffer |
| `i` | o v x | Inside textobject |
| `il` | o v x | Inside last textobject |
| `in` | o v x | Inside next textobject |
| `j` | n v x | Down |
| `jj` | i | Exit insert mode |
| `k` | n v x | Up |
| `L` | n | Next Buffer |
| `n` | n o v x | Next Search Result |
| `N` | n o v x | Prev Search Result |
| `p` | n v x | Put after |
| `P` | n v x | Put before |
| `Q` | v x | :help v_Q-default |
| `r` | o | Remote Flash |
| `R` | o v x | Treesitter Search |
| `s` | n o v x | Flash |
| `S` | n o v x | Flash Treesitter |
| `Y` | n | :help Y-default |

## Regenerating this file

This file is generated, not hand-maintained. To refresh it after adding or
changing keymaps, dump the live table from a fully loaded Neovim and rebuild
the tables - the generator lives in the commit that introduced this file.
