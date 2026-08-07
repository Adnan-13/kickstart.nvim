-- Custom prerequisite check for this config, on top of Neovim's built-in
-- :checkhealth. Run with `:checkhealth config` (or plain `:checkhealth`,
-- which discovers this automatically).
--
-- This only reports; it never installs anything itself - see bootstrap/
-- for one-time setup scripts that fix most of what this flags.

local M = {}

local function exe(name)
  return vim.fn.executable(name) == 1
end

local function is_windows()
  return vim.fn.has("win32") == 1
end

local function python_venv_path()
  if is_windows() then
    return vim.fn.expand("~/.local/share/nvim/python_provider/Scripts/python.exe")
  end
  return vim.fn.expand("~/.local/share/nvim/python_provider/bin/python3")
end

function M.check()
  vim.health.start("Core tools")

  if vim.fn.has("nvim-0.10") == 1 then
    vim.health.ok("Neovim version: " .. tostring(vim.version()))
  else
    vim.health.error("Neovim 0.10+ required", { "Update Neovim: https://neovim.io/" })
  end

  if exe("git") then
    vim.health.ok("git found")
  else
    vim.health.error("git not found", { "Required to install lazy.nvim and all plugins.", "Run bootstrap/setup." })
  end

  -- C compiler, needed for treesitter parsers to build
  local compilers = is_windows() and { "zig", "gcc", "clang", "cl" } or { "cc", "gcc", "clang" }
  local have_compiler = false
  for _, c in ipairs(compilers) do
    if exe(c) then
      vim.health.ok("C compiler found: " .. c)
      have_compiler = true
      break
    end
  end
  if not have_compiler then
    vim.health.error(
      "No C compiler found (needed to build Treesitter parsers)",
      { "Run bootstrap/setup to install one (zig on Windows, gcc on Linux)." }
    )
  end

  if exe("rg") then
    vim.health.ok("ripgrep found (grep search)")
  else
    vim.health.warn("ripgrep (rg) not found - grep/search pickers will fail", { "Run bootstrap/setup." })
  end

  if exe("fd") or exe("fdfind") then
    vim.health.ok("fd found (fast file finding)")
  else
    vim.health.warn("fd not found - file pickers fall back to a slower method", { "Run bootstrap/setup." })
  end

  vim.health.start("Node.js (typescript-tools, copilot, yaml/angular LSPs, prettier)")
  if exe("node") and exe("npm") then
    vim.health.ok("node + npm found")
    local ts_ok = vim.fn.system({ "npm", "ls", "-g", "typescript" })
    if ts_ok:find("empty") or vim.v.shell_error ~= 0 then
      vim.health.warn("global `typescript` npm package not found (typescript-tools needs tsserver.js)", {
        "npm install -g typescript@5   -- must be 5.x, not 7.x (7.x dropped tsserver.js)",
      })
    else
      vim.health.ok("global typescript package found")
    end
  else
    vim.health.error("node/npm not found", { "Required for typescript-tools, copilot, yamlls, angularls, prettier.", "Run bootstrap/setup." })
  end

  vim.health.start("Python")
  if exe("python3") or exe("python") then
    vim.health.ok("python found on PATH")
  else
    vim.health.warn("no python3/python found on PATH", { "Only needed if you use :python3 or Python-related plugins." })
  end
  if vim.fn.filereadable(python_venv_path()) == 1 then
    vim.health.ok("dedicated python provider venv found: " .. python_venv_path())
  else
    vim.health.info("no dedicated python provider venv (optional)", {
      "Run bootstrap/setup to create one, or ignore if you don't need :python3.",
    })
  end
  if is_windows() and exe("pyenv") then
    -- :checkhealth vim.provider warns that it "failed to infer the root of
    -- pyenv by running `pyenv root`". That check assumes Unix pyenv; pyenv-win
    -- has never implemented a `root` subcommand, so the warning fires even on a
    -- perfectly healthy install and can be ignored.
    vim.health.info("pyenv-win detected: the builtin `pyenv root` provider warning is expected, not a fault")
  end

  vim.health.start("Clipboard")
  if is_windows() then
    if exe("win32yank.exe") then
      vim.health.ok("win32yank.exe found")
    else
      vim.health.warn("win32yank.exe not found - falling back to a slower PowerShell clipboard", { "Run bootstrap/setup." })
    end
  elseif vim.fn.has("wsl") == 1 then
    if exe("win32yank.exe") then
      vim.health.ok("win32yank.exe found (WSL)")
    else
      vim.health.warn("win32yank.exe not found under WSL", { "Install it on the Windows side and ensure it's on WSL's PATH." })
    end
  else
    if exe("xclip") or exe("xsel") or exe("wl-copy") then
      vim.health.ok("a Linux clipboard tool was found")
    else
      vim.health.warn("no clipboard tool found (xclip/xsel/wl-clipboard)", { "Run bootstrap/setup, or install one manually." })
    end
  end

  vim.health.start("SQL (vim-dadbod)")
  -- dadbod shells out to a per-database CLI client rather than bundling drivers,
  -- so <leader>D opens its UI regardless but every query fails without one.
  if exe("sqlite3") then
    vim.health.ok("sqlite3 found")
  else
    vim.health.warn("sqlite3 not found - dadbod can't query SQLite databases", {
      "Run bootstrap/setup.",
      "Other engines need their own client on PATH (psql, mysql, sqlcmd, ...).",
    })
  end

  vim.health.start("Terminal font")
  vim.health.info("Nerd Font can't be checked programmatically - if icons look broken, install one from https://www.nerdfonts.com/ and select it in your terminal.")
end

return M
