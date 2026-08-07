# Agent Instructions

Personal Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim)
(migrated from a heavily customized [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
fork — see `LEGACY-FEATURES.md` and the `my-kickstart-old-config` branch for that history).
See `README.md` for setup/installation.

This file is the canonical, cross-tool instructions file for every AI
coding agent working in this repo (Cursor, GitHub Copilot, Claude Code,
etc). `.github/copilot-instructions.md` and `CLAUDE.md` exist only as
bridges for tools that don't read `AGENTS.md` natively — edit the rules
here, not there, so the two stay in sync automatically.

## Hard constraints

- **Cross-platform, always.** This config is used on both Windows and
  Linux from the same `my-config` branch. Never add a change that only
  works on one OS without gating it behind `vim.fn.has("win32")` (see
  `lua/config/options.lua` for the pattern) or otherwise no-op'ing
  cleanly on the other platform.
- **Windows shell is PowerShell, not cmd.** When running shell commands
  for this repo on Windows, use PowerShell syntax (`;` separators, no
  bash heredocs, `Start-Process`/`Get-Process` etc.), not `cmd /c`.
- **LazyVim extras are imported top-level in `lua/config/lazy.lua`**,
  inside the `spec` table, after `lazyvim.plugins` and before
  `{ import = "plugins" }`. Importing an extra from inside
  `lua/plugins/*.lua` instead triggers LazyVim's "import order incorrect"
  warning. Custom overrides/config for an extra (e.g. language-specific
  DAP or test adapters) go in `lua/plugins/*.lua` as normal plugin specs
  that extend what the extra already declared.

## Repo layout

- `init.lua` — bootstraps `lua/config/lazy.lua`. Don't add logic here.
- `lua/config/options.lua` — vim options + Windows-only provider/clipboard/
  compiler fixes (all gated, no-op on Linux).
- `lua/config/keymaps.lua` — custom keymaps beyond LazyVim's defaults.
- `lua/config/autocmds.lua` — custom autocommands beyond LazyVim's defaults.
- `lua/config/health.lua` — `:checkhealth config`: reports missing
  cross-platform prerequisites (compiler, ripgrep, fd, node, python,
  clipboard tool). Report-only; never installs anything — that's what
  `bootstrap/` is for.
- `lua/config/lazy.lua` — lazy.nvim bootstrap + the list of LazyVim extras
  enabled (each has a comment explaining what it adds and its keymap
  prefix).
- `lua/plugins/*.lua` — one file per custom plugin or per extra needing
  language-specific config (`dap.lua`, `test.lua`, `python.lua`,
  `typescript.lua`, `yaml.lua`, etc.). Each `return { ... }` is a lazy.nvim
  plugin spec table, merged with whatever LazyVim/the extra already
  declared for that plugin name.
- `bootstrap/setup.ps1` / `bootstrap/setup.sh` — one-time, idempotent,
  OS-specific prerequisite installers (compiler, ripgrep, fd, Python venv,
  global npm packages). Update these, not ad-hoc manual instructions, when
  a new tool becomes a hard dependency.
- `LEGACY-FEATURES.md` — historical record of the pre-LazyVim setup; only
  touch it if revisiting migration history, not for new work.

## Testing changes

Before committing any plugin/keymap change, verify it actually works —
"loads without erroring" is not sufficient evidence; this config has hit
real bugs (see below) that only appeared when the actual keymap or a real
input file was exercised, not when the underlying Lua function was called
directly or the plugin was just checked for load errors.

1. **Fast syntax/load smoke test:**
   ```sh
   nvim --headless -c "qa"
   ```
   Should exit 0 with no errors. Follow with `nvim --headless -c "lua print(vim.g.colors_name)" -c "qa"` to confirm the full plugin spec resolves.
2. **Real interactive verification (preferred for anything with a keymap,
   LSP, DAP, or external process involved):** start a real, persistent
   Neovim RPC server and drive it with actual keystrokes, so keymap/
   which-key dispatch is exercised exactly as a user would trigger it —
   not just calling the underlying Lua function directly:
   ```powershell
   nvim --headless --listen '\\.\pipe\nvimtest'   # background this
   nvim --headless --server '\\.\pipe\nvimtest' --remote-send ' ff'
   nvim --headless --server '\\.\pipe\nvimtest' --remote-expr 'luaeval("1+1")'
   ```
   Notes: both the server *and* the client invocation need `--headless`
   on Windows, or the client tries to negotiate a terminal UI and prints
   garbage escape codes instead of running. `<leader>` is not a special
   token for `--remote-send` — send the literal leader key (e.g. a space)
   instead. Wrap Lua expressions passed through `--remote-expr` in
   `luaeval("...")`, using double-quoted Lua strings inside a
   single-quoted PowerShell argument to avoid nested-quote hell.
3. Create real scratch input files (a `.py`/`.http`/`Dockerfile`/etc. in a
   temp dir) for anything that depends on file content, an LSP, a linter,
   or an external process — don't assume a plugin's parsing/matching logic
   is correct just because it doesn't throw.
4. Run `:checkhealth config` and `:checkhealth lazy` after larger changes.

## Known upstream limitations (don't re-attempt without checking first)

- **`neotest-jest` and `neotest-vitest` are both broken on Windows** and
  are not wired up in `lua/plugins/test.lua` (only `neotest-python` is).
  Both build their neotest result-matching key from the raw,
  backslash-separated path returned by their test runner's JSON reporter,
  while neotest's own position IDs are forward-slash normalized
  (`vim.fs.normalize(pos.path)`) — the two never match on Windows, so
  results come back wrong (jest: "0 matches", every run fails; vitest:
  every test reported failed regardless of actual outcome).
  `neotest-vitest/lua/neotest-vitest/util.lua` even has an unused
  `sanitize()` helper that would fix this but is never called. Revisit
  only if upstream fixes it; verify with a real mixed pass/fail file
  (method 2/3 above) before re-enabling, not just a clean run.
- **Treesitter parser compilation on Windows** can fail with MSVC
  ("error C1002", out of heap space) on large generated parsers (e.g.
  `gitcommit`) if `cl.exe` is first on PATH. Fixed by forcing
  `vim.env.CC = "gcc"` on Windows in `lua/config/options.lua` — don't
  remove that without confirming MSVC handles all current parsers.
- **`:checkhealth vim.provider` pyenv warning on Windows** ("Failed to infer
  the root of pyenv by running `pyenv root`") is a false positive, not a broken
  install. That probe assumes Unix pyenv; pyenv-win has never implemented a
  `root` subcommand (`pyenv commands` confirms it isn't in the list). The
  Python provider is pinned explicitly via `vim.g.python3_host_prog` anyway.
  Don't try to "fix" pyenv over it.
- **`nvim-dap` adapter executables on Windows**: Mason installs
  `debugpy-adapter`/`js-debug-adapter` as `.CMD` shims. `nvim-dap` spawns
  commands directly via libuv with no PATHEXT resolution, so bare command
  names fail even though `vim.fn.executable()` finds them — resolve full
  paths with `vim.fn.exepath()` first (see `lua/plugins/dap.lua`).
  Additionally, spawning `debugpy-adapter`'s `.CMD` wrapper through
  `cmd.exe` corrupts stdio framing; point `nvim-dap-python` at the Mason
  venv's `python.exe` directly instead.

## Commit Messages

Use the **Conventional Commits** format: `<type>(<scope>): <description>`

- **Types**: `feat`, `fix`, `refactor`, `style`, `docs`, `perf`, `chore`
- **Scope**: optional, usually the plugin or area touched (e.g. `feat(blink): ...`)
- **Title**: first line under 50 characters, lowercase after the colon, no trailing period
- **Body**: blank line after the title, wrapped at 72 characters, `-` bullet points for multiple changes
- Wrap the final commit message in a triple-backtick code block for easy copying

Example:

```
feat(blink): switch keymap to super-tab preset

- replace default preset with super-tab for tab-driven completion
```

## Branches

- `my-config` — the active branch; all work happens here.
- `master` — tracks upstream `nvim-lua/kickstart.nvim` unmodified, for
  diffing/reference only. Don't commit work here.
- `my-kickstart-old-config` — frozen snapshot of the pre-LazyVim fork,
  kept for history (see `LEGACY-FEATURES.md`). Don't commit work here.
