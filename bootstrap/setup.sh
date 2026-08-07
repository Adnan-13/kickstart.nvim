#!/usr/bin/env bash
# One-time setup for this Neovim config on Linux. Installs missing system
# prerequisites via the detected package manager, creates a dedicated Python
# provider venv, and installs the global npm packages the LSP/formatter
# tooling needs.
#
# Usage: run once after cloning this repo and checking out the target branch:
#   bash bootstrap/setup.sh
#
# Safe to re-run - every step checks whether it's already done first.
# Supports apt (Debian/Ubuntu), dnf (Fedora), and pacman (Arch). Anything
# else: install the listed prerequisites manually, then re-run to get the
# npm/venv steps.

set -uo pipefail

step() { printf '\n\033[36m==> %s\033[0m\n' "$1"; }
ok() { printf '  \033[32m[ok]\033[0m %s\n' "$1"; }
skip() { printf '  \033[90m[skip]\033[0m %s\n' "$1"; }
warn() { printf '  \033[33m[warn]\033[0m %s\n' "$1"; }

have() { command -v "$1" >/dev/null 2>&1; }

PKG_MANAGER=""
if have apt-get; then PKG_MANAGER="apt"
elif have dnf; then PKG_MANAGER="dnf"
elif have pacman; then PKG_MANAGER="pacman"
fi

install_pkgs() {
  case "$PKG_MANAGER" in
    apt)
      sudo apt-get update -qq
      sudo apt-get install -y "$@"
      ;;
    dnf)
      sudo dnf install -y "$@"
      ;;
    pacman)
      sudo pacman -Sy --noconfirm "$@"
      ;;
    *)
      warn "No supported package manager (apt/dnf/pacman) detected."
      warn "Install manually: $*"
      return 1
      ;;
  esac
}

step "Checking / installing system prerequisites"

need_pkgs=()
have git || need_pkgs+=("git")
have rg || case "$PKG_MANAGER" in
  apt) need_pkgs+=("ripgrep") ;;
  dnf) need_pkgs+=("ripgrep") ;;
  pacman) need_pkgs+=("ripgrep") ;;
esac
have fd || have fdfind || case "$PKG_MANAGER" in
  apt) need_pkgs+=("fd-find") ;;  # binary is `fdfind` on Debian/Ubuntu
  dnf) need_pkgs+=("fd-find") ;;
  pacman) need_pkgs+=("fd") ;;
esac
have gcc || have cc || case "$PKG_MANAGER" in
  apt) need_pkgs+=("build-essential") ;;
  dnf) need_pkgs+=("gcc" "make") ;;
  pacman) need_pkgs+=("base-devel") ;;
esac
have node || case "$PKG_MANAGER" in
  apt) need_pkgs+=("nodejs" "npm") ;;
  dnf) need_pkgs+=("nodejs" "npm") ;;
  pacman) need_pkgs+=("nodejs" "npm") ;;
esac
have python3 || need_pkgs+=("python3")
if ! python3 -c "import venv" >/dev/null 2>&1; then
  case "$PKG_MANAGER" in
    apt) need_pkgs+=("python3-venv") ;;
  esac
fi
have xclip || have xsel || have wl-copy || case "$PKG_MANAGER" in
  apt) need_pkgs+=("xclip") ;;
  dnf) need_pkgs+=("xclip") ;;
  pacman) need_pkgs+=("xclip") ;;
esac
# vim-dadbod shells out to a per-database CLI client; without one, <leader>D
# opens the UI but no query can run. sqlite3 covers the local-file case.
have sqlite3 || case "$PKG_MANAGER" in
  apt) need_pkgs+=("sqlite3") ;;
  dnf) need_pkgs+=("sqlite") ;;
  pacman) need_pkgs+=("sqlite") ;;
esac

if [ "${#need_pkgs[@]}" -gt 0 ]; then
  step "Installing: ${need_pkgs[*]}"
  install_pkgs "${need_pkgs[@]}" || warn "Some packages may not have installed - see above."
else
  skip "All system prerequisites already present"
fi

if have apt-get && ! have fd && have fdfind; then
  warn "fd is installed as 'fdfind' on this distro - consider: ln -s \$(which fdfind) ~/.local/bin/fd"
fi

step "Global npm packages for LSP tooling"
# npm_install_g: tries a normal global install first; system-packaged Node.js
# on Linux commonly defaults to a root-owned prefix (e.g. /usr/local), which
# fails silently with EACCES for a regular user, so fall back to sudo only
# if that specific failure happens - rather than always requiring sudo, or
# always failing silently on distros where it isn't needed.
npm_install_g() {
  local pkg="$1" out
  out=$(npm install -g "$pkg" 2>&1)
  if [ $? -eq 0 ]; then
    return 0
  fi
  if echo "$out" | grep -q "EACCES"; then
    warn "npm global prefix isn't writable by this user, retrying '$pkg' with sudo"
    sudo npm install -g "$pkg" >/dev/null 2>&1
    return $?
  fi
  warn "npm install -g $pkg failed:"
  echo "$out" | tail -5
  return 1
}

if have npm; then
  # Pinned to 5.x deliberately: typescript@7 is Microsoft's new native compiler
  # preview and does not ship tsserver.js, which typescript-tools.nvim needs.
  npm_install_g "typescript@5" && ok "typescript@5 installed globally (tsserver for typescript-tools.nvim)"
  npm_install_g "neovim" && ok "neovim npm package installed globally (Node.js provider)"
  # nvim-dap launches .ts files through a TypeScript-aware runtime (see
  # lua/plugins/dap.lua). Without tsx or ts-node on PATH the adapter starts and
  # immediately disconnects, so TS debugging fails while plain JS still works.
  npm_install_g "tsx" && ok "tsx installed globally (TypeScript runtime for nvim-dap launches)"
else
  warn "npm not found - skipping global npm installs. Re-run after Node.js is on PATH."
fi

step "Python provider venv"
venv_dir="$HOME/.local/share/nvim/python_provider"
if [ -x "$venv_dir/bin/python3" ]; then
  skip "Python provider venv already exists at $venv_dir"
elif have python3; then
  step "Creating Python provider venv at $venv_dir"
  python3 -m venv "$venv_dir"
  "$venv_dir/bin/python3" -m pip install --upgrade pip pynvim >/dev/null 2>&1
  ok "Python provider venv created with pynvim installed"
else
  warn "python3 not found - skipping venv creation. Only needed for :python3 usage."
fi

step "Done. Open Neovim, run :Lazy sync to install plugins, then :checkhealth config to verify everything."
