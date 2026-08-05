# 💤 Personal Neovim Config (LazyVim)

A [LazyVim](https://github.com/LazyVim/LazyVim)-based personal Neovim
configuration. Works on Windows and Linux from the same branch (`my-config`).

## Setup on a new machine

```sh
git clone <this-repo-url> "$HOME/.config/nvim"   # Linux
# or, on Windows (PowerShell):
git clone <this-repo-url> "$env:LOCALAPPDATA\nvim"

cd <cloned-path>
git checkout my-config
```

Then run the one-time bootstrap script for your OS - it installs missing
system prerequisites, creates the Python provider venv, and installs the
global npm packages the LSP/formatter tooling needs. It's safe to re-run.

- **Windows** (PowerShell): `powershell -ExecutionPolicy Bypass -File bootstrap\setup.ps1`
- **Linux** (bash, supports apt/dnf/pacman): `bash bootstrap/setup.sh`

Then open `nvim`. Plugins install automatically on first launch. Once
installed, run `:checkhealth config` to verify every prerequisite - LSP
servers, formatters, treesitter, clipboard, and the Python provider - is
actually working, not just present.

## What's here

- LazyVim core, with a custom `lua/plugins/` layer for:
  TypeScript/Angular/React (`typescript.lua`), YAML + Kubernetes/GitHub
  Actions schemas (`yaml.lua`), Python (`python.lua`), GitHub Copilot
  (imported in `lua/config/lazy.lua`), and a handful of editor extras
  (yanky, render-markdown, rainbow-delimiters, diffview, colorizer).
- `catppuccin` (mocha) as the colorscheme.
- `jj` to exit insert mode, and mini.surround remapped to a `<leader>S*`
  menu (kept off `<leader>s`, which LazyVim reserves for search).
- Windows-specific fixes in `lua/config/options.lua` (clipboard, Node/Python
  provider paths) that no-op on Linux.
- `LEGACY-FEATURES.md` documents what this replaced (a heavily customized
  kickstart.nvim fork) for anyone curious about the migration history.

## Manual prerequisites the bootstrap scripts don't cover

- Neovim itself. On Windows, install/update via
  [Scoop](https://scoop.sh/) - the community-recommended option (no admin
  rights, no registry writes, easy in-place updates):
  ```powershell
  scoop bucket add main   # if not already added
  scoop install neovim    # install
  scoop update neovim     # update to the latest stable release later
  ```
  Winget (`winget install/upgrade Neovim.Neovim`) and Chocolatey
  (`choco install/upgrade neovim`) both work too, but don't mix installers -
  pick one so `nvim` on PATH always resolves to a single, known install.
  On Linux, distro repos are often stale; prefer the
  [official PPA](https://github.com/neovim/neovim/blob/master/INSTALL.md#ubuntu),
  an AppImage, or a version manager like [bob](https://github.com/MordechaiHadad/bob).
- A [Nerd Font](https://www.nerdfonts.com/) installed and selected in your
  terminal (can't be verified or installed by a script reliably).
- `:Copilot auth` once, interactively, to authorize GitHub Copilot.
