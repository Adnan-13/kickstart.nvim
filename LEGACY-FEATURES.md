# Legacy kickstart.nvim Features

This documents everything the pre-LazyVim configuration (fork of
[nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)) had on
top of stock kickstart, captured just before the LazyVim rebuild. The full
old source is preserved on the `my-kickstart-old-config` branch if any of
this needs to be referenced in detail. Used as the checklist for the Phase 3
"what to keep" review of the LazyVim migration.

## Structural difference from stock kickstart

Stock kickstart ships `lua/kickstart/plugins/*.lua` as opt-in files,
commented out in `init.lua` by default. This fork's `init.lua` unconditionally
imported all of them via `{ import = 'kickstart.plugins' }`, so several
"optional" stock plugins were actually force-enabled:

- `debug.lua` — nvim-dap + nvim-dap-ui + nvim-dap-go + mason-nvim-dap (Go debugging)
- `indent_line.lua` — indent-blankline.nvim
- `lint.lua` — nvim-lint with markdownlint
- `autopairs.lua` — nvim-autopairs
- `neo-tree.lua` — file explorer, heavily customized (path-preview popup, `follow_current_file`, dotfiles shown)
- gitsigns "extra keymaps" file — hunk stage/reset/preview/blame/diff keymaps

## Plugins added beyond stock kickstart entirely

All of the following are wired up via `lua/custom/plugins/init.lua`, which
*is* imported in `init.lua` (`{ import = 'custom.plugins' }` alongside
`{ import = 'kickstart.plugins' }`) — so unlike an earlier draft of this
document assumed, these are all genuinely active, not dead code:

- `stevearc/oil.nvim` — buffer-based file explorer (bound to `-`)
- `folke/flash.nvim` — enhanced motion/jump (`s`, `S`, `r`, `R`)
- `folke/snacks.nvim` — dashboard, notifier, picker, scroll, words, quickfix,
  statuscolumn, and LazyGit integration (`<leader>gg`, `<leader>sp`, `<leader>ff` [conflicts — see bug note below])
- `sindrets/diffview.nvim` — git diff viewer (`<leader>gd`)
- `gbprod/yanky.nvim` — yank history / enhanced put (remaps `p`/`P`)
- `catgoose/nvim-colorizer.lua` — inline color swatches
- `pmizio/typescript-tools.nvim` — TS/JS language plugin (see duplicate-spec bug below)
- `windwp/nvim-ts-autotag` — HTML/JSX auto-close/rename tags (see duplicate-spec bug below)
- `MeanderingProgrammer/render-markdown.nvim` — in-buffer markdown rendering
- `HiPhish/rainbow-delimiters.nvim` — rainbow bracket highlighting
- `rmagatti/auto-session` — session save/restore/search (`<leader>ws`, `<leader>wS`, `<leader>wa`)

## LSP / formatting additions beyond stock

- `angularls`, root-gated to Angular/Nx projects (`angular.json`/`nx.json`)
- `yamlls` with JSON schemas for Kubernetes manifests and GitHub Actions workflows
- `pyright`
- `ts_ls` explicitly disabled in favor of `typescript-tools`
- `conform.nvim` formatter map greatly expanded: JS/TS/JSX/TSX/HTML/CSS/Angular/JSON/YAML/Markdown
  via `prettierd`/`prettier`, with custom args (`--tab-width 4 --single-quote
  --jsx-single-quote --single-attribute-per-line --no-bracket-spacing`) and
  `PRETTIERD_DEFAULT_CONFIG` pointed at `~/.prettierrc.json`
- Extra Mason-installed tools: `prettierd`, `isort`, `black`
- Treesitter parser list expanded well beyond stock's minimal set: `angular`,
  `javascript`, `jsdoc`, `json`, `jsonc`, `typescript`, `tsx`, `yaml`, `css`,
  `scss`, `regex`, `svelte`, `vue`, `sql`

## Editor options / keymaps beyond stock

Documented in more detail in `KEYBINDS.md` (also being replaced). Highlights:

- Quick-save: `<leader>w`, `<leader>fs`, `<C-s>`; quit-all `<leader>qq`
- `H`/`L` and `[b`/`]b` buffer switching, `<leader>bd` buffer delete
- Centered scrolling (`<C-d>`/`<C-u>` + `zz`), visual-mode line move (`J`/`K`)
- Yank-all (`<leader>ya`), explicit clipboard paste (`<leader>p`)
- Windows clipboard: prefers `win32yank.exe`, falls back to a PowerShell
  `Set-Clipboard`/`Get-Clipboard` wrapper that strips `\r\n`
- Windows Node.js/Python provider detection fixes (`neovim-node-host.cmd`
  unwrapping, dedicated Python venv path, Perl/Ruby providers disabled)
- `relativenumber = true`, `tabstop`/`shiftwidth = 4`, `smartindent = true`,
  Treesitter-based folding (`foldlevel/foldlevelstart = 99`)

A lot of this already matches LazyVim's own defaults (find-files, buffer
delete, window nav via `<C-hjkl>`), so most of Phase 3 here should just be
confirming LazyVim already covers it rather than re-adding it. The Windows
clipboard/provider fixes are platform-correctness fixes, not preferences —
recommended to always carry forward regardless of what else is kept.

## Theme

`tokyonight-night`, not transparent, with a custom `on_highlights` override
forcing higher-contrast highlight groups for JS/TS (`@keyword`, `@type`,
`@variable.member`, `@function`, etc). Low-conflict: LazyVim's own default
colorscheme is also tokyonight, so only the custom highlight overrides are
actually in question.

## Known bugs — not being carried forward as "features"

Found during this audit; these were unintentional and should not be
replicated in the new setup. All stem from the same root cause: two
different plugin sources (`lua/kickstart/plugins/*.lua` +
`lua/config/keymaps.lua` vs. `lua/custom/plugins/init.lua`'s snacks.nvim
entry) independently defined overlapping keymaps/specs, and lazy.nvim's
load-order silently decided which one actually won at runtime — with no
error or warning either way:

- **`typescript-tools.nvim` configured twice**: once in
  `lua/custom/plugins/init.lua` (`opts = {}`, minimal) and once in
  `lua/kickstart/plugins/typescript-tools.lua` (full config with Angular
  exclusion logic).
- **`nvim-ts-autotag` configured twice** the same way (custom/plugins/init.lua
  and `lua/kickstart/plugins/ts-autotag.lua`).
- **`<leader>e` bound twice**: `lua/config/keymaps.lua` → `:Lex 30` (netrw)
  vs. `lua/kickstart/plugins/neo-tree.lua` → `:Neotree toggle`.
- **`<leader>ff` bound twice**: `lua/kickstart/plugins/telescope.lua` →
  `builtin.find_files` vs. `lua/custom/plugins/init.lua`'s snacks entry →
  `snacks.picker.files()`.
- **`<leader>bd` bound twice**: `lua/config/keymaps.lua` → `:bd<CR>` vs.
  `lua/custom/plugins/init.lua`'s snacks entry → `snacks.bufdelete()`.
- **`<leader>sd` and `<leader>sk` bound twice each**: once in
  `lua/kickstart/plugins/telescope.lua` (diagnostics/keymaps pickers) and
  again in the snacks entry in `lua/custom/plugins/init.lua` (same actions,
  different picker backend).

Net effect: two competing pickers (Telescope and snacks.picker) and two
competing file explorers (netrw and neo-tree) were both installed and
fighting over the same keys the whole time, rather than a single
deliberate choice for each role.
