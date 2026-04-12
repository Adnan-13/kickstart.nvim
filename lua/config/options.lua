-- [[ Options ]]
-- See `:help vim.o`
-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Ensure true color support for better syntax highlighting
vim.opt.termguicolors = true

-- Specify the Python provider to use a dedicated venv
if vim.fn.has 'win32' == 1 then
    vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim/python_provider/Scripts/python.exe")
else
    vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim/python_provider/bin/python3")
end

-- Disable Perl and Ruby providers to silence health check errors/warnings
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Fix Node.js provider on Windows (nvm4w / .CMD wrapper issue)
if vim.fn.has 'win32' == 1 then
    local node_path = vim.fn.exepath('neovim-node-host.cmd')
    if node_path ~= '' then
        -- Neovim passes the host_prog to node directly. Passing a .cmd file to node fails.
        -- We extract the path and point directly to the underlying cli.js file.
        local js_host = vim.fn.fnamemodify(node_path, ':h') .. '\\node_modules\\neovim\\bin\\cli.js'
        if vim.fn.filereadable(js_host) == 1 then
            vim.g.node_host_prog = js_host
        end
    end
end

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true -- Better for 10x productivity motions

-- Enable mouse mode
vim.o.mouse = 'a'

-- Don't show the mode
vim.o.showmode = false

-- Sync clipboard
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Enable undo persistence
vim.o.undofile = true

-- Search settings
vim.o.ignorecase = true
vim.o.smartcase = true

-- UI settings
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '␣'
}
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- Better tab settings for web dev
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Fix fold settings for Treesitter
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

