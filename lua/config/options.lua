-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Windows platform-correctness fixes (not preferences - needed regardless of
-- editor distro to make providers and clipboard work correctly on Windows).

-- Dedicated Python venv, if one has been provisioned (see bootstrap/ scripts).
-- Only point at it if it actually exists - pointing vim.g.python3_host_prog at
-- a missing path breaks the provider outright instead of falling back to
-- Neovim's own python3-on-PATH auto-detection, which works fine without a
-- dedicated venv for basic :python3/pynvim usage.
local python_venv = vim.fn.has("win32") == 1 and vim.fn.expand("~/.local/share/nvim/python_provider/Scripts/python.exe")
  or vim.fn.expand("~/.local/share/nvim/python_provider/bin/python3")
if vim.fn.filereadable(python_venv) == 1 then
  vim.g.python3_host_prog = python_venv
end

-- Silence Perl/Ruby provider health-check noise (neither is used here)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Fix Node.js provider on Windows (nvm4w / .CMD wrapper issue): Neovim passes
-- host_prog to node directly, and a .cmd file can't be passed to node, so
-- resolve the underlying cli.js instead.
if vim.fn.has("win32") == 1 then
  local node_path = vim.fn.exepath("neovim-node-host.cmd")
  if node_path ~= "" then
    local js_host = vim.fn.fnamemodify(node_path, ":h") .. "\\node_modules\\neovim\\bin\\cli.js"
    if vim.fn.filereadable(js_host) == 1 then
      vim.g.node_host_prog = js_host
    end
  end
end

-- Clipboard: prefer win32yank.exe (no ^M issues), fall back to a PowerShell
-- wrapper that strips \r\n on paste.
if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
  if vim.fn.executable("win32yank.exe") == 1 then
    vim.g.clipboard = {
      name = "win32yank-local",
      copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
      },
      paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
      },
      cache_enabled = 0,
    }
  else
    local clipboard_exe = vim.fn.executable("pwsh") == 1 and "pwsh.exe" or "powershell.exe"
    vim.g.clipboard = {
      name = "PowershellClipboard",
      copy = {
        ["+"] = clipboard_exe .. ' -NoLogo -NoProfile -Command "$input | Set-Clipboard"',
        ["*"] = clipboard_exe .. ' -NoLogo -NoProfile -Command "$input | Set-Clipboard"',
      },
      paste = {
        ["+"] = clipboard_exe
          .. ' -NoLogo -NoProfile -Command "[Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace(\\"`r`n\\", \\"`n\\"))"',
        ["*"] = clipboard_exe
          .. ' -NoLogo -NoProfile -Command "[Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace(\\"`r`n\\", \\"`n\\"))"',
      },
      cache_enabled = 0,
    }
  end
end
