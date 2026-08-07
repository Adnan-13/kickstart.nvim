#Requires -Version 5.1
<#
.SYNOPSIS
  One-time setup for this Neovim config on Windows. Installs missing system
  prerequisites via winget, creates a dedicated Python provider venv, and
  installs the global npm packages the LSP/formatter tooling needs.

.USAGE
  Run once after cloning this repo and checking out the target branch:
    powershell -ExecutionPolicy Bypass -File bootstrap\setup.ps1

  Safe to re-run - every step checks whether it's already done first.
#>

$ErrorActionPreference = "Continue"

function Write-Step($msg) { Write-Host "`n==> $msg" -ForegroundColor Cyan }
function Write-Ok($msg) { Write-Host "  [ok] $msg" -ForegroundColor Green }
function Write-Skip($msg) { Write-Host "  [skip] $msg" -ForegroundColor DarkGray }
function Write-Warn2($msg) { Write-Host "  [warn] $msg" -ForegroundColor Yellow }

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
  Write-Warn2 "winget not found. Install 'App Installer' from the Microsoft Store, then re-run this script."
  Write-Warn2 "Continuing with whatever is already on PATH..."
}

function Install-WithWinget($id, $displayName, $checkCommand) {
  if ($checkCommand -and (Get-Command $checkCommand -ErrorAction SilentlyContinue)) {
    Write-Skip "$displayName already installed"
    return
  }
  if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Step "Installing $displayName ($id)"
    winget install --id $id -e --accept-source-agreements --accept-package-agreements --silent
    Write-Ok "$displayName installed (or already present)"
  } else {
    Write-Warn2 "Cannot install $displayName automatically without winget - install it manually."
  }
}

Write-Step "Checking / installing system prerequisites"
Install-WithWinget "Git.Git" "git" "git"
Install-WithWinget "BurntSushi.ripgrep.MSVC" "ripgrep" "rg"
Install-WithWinget "sharkdp.fd" "fd" "fd"
Install-WithWinget "OpenJS.NodeJS.LTS" "Node.js LTS" "node"
Install-WithWinget "Python.Python.3.12" "Python 3.12" "python"
Install-WithWinget "zig.zig" "Zig (C compiler for Treesitter parsers)" "zig"
Install-WithWinget "equalsraf.win32yank" "win32yank (fast clipboard)" "win32yank.exe"
# vim-dadbod shells out to a per-database CLI client; without one, <leader>D
# opens the UI but no query can run. sqlite3 covers the local-file case.
Install-WithWinget "SQLite.SQLite" "sqlite3 (vim-dadbod query client)" "sqlite3"

# Refresh PATH in this session so newly-installed tools are visible below
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

function Install-NpmGlobal($pkg, $label) {
  $out = npm install -g $pkg 2>&1
  if ($LASTEXITCODE -eq 0) {
    Write-Ok "$label installed globally"
  } else {
    Write-Warn2 "npm install -g $pkg failed:"
    $out | Select-Object -Last 5 | ForEach-Object { Write-Warn2 "  $_" }
  }
}

Write-Step "Global npm packages for LSP tooling"
if (Get-Command npm -ErrorAction SilentlyContinue) {
  # Pinned to 5.x deliberately: typescript@7 is Microsoft's new native compiler
  # preview and does not ship tsserver.js, which typescript-tools.nvim needs.
  Install-NpmGlobal "typescript@5" "typescript@5 (tsserver for typescript-tools.nvim)"
  Install-NpmGlobal "neovim" "neovim npm package (Node.js provider)"
  # nvim-dap launches .ts files through a TypeScript-aware runtime (see
  # lua/plugins/dap.lua). Without tsx or ts-node on PATH the adapter starts and
  # immediately disconnects, so TS debugging fails while plain JS still works.
  Install-NpmGlobal "tsx" "tsx (TypeScript runtime for nvim-dap launches)"
} else {
  Write-Warn2 "npm not found - skipping global npm installs. Re-run after Node.js is on PATH."
}

Write-Step "Python provider venv"
$venvDir = Join-Path $env:USERPROFILE ".local\share\nvim\python_provider"
$venvPython = Join-Path $venvDir "Scripts\python.exe"
if (Test-Path $venvPython) {
  Write-Skip "Python provider venv already exists at $venvDir"
} else {
  $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
  if ($pythonCmd) {
    Write-Step "Creating Python provider venv at $venvDir"
    python -m venv $venvDir
    & $venvPython -m pip install --upgrade pip pynvim | Out-Null
    Write-Ok "Python provider venv created with pynvim installed"
  } else {
    Write-Warn2 "python not found - skipping venv creation. Only needed for :python3 usage."
  }
}

Write-Step "Done. Open Neovim, run :Lazy sync to install plugins, then :checkhealth config to verify everything."
