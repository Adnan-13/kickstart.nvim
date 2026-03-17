-- [[ Keymaps ]]

-- Exit term mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Quick save
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Quick [w]rite' })

-- Clear highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to Right window' })

-- Buffer navigation
vim.keymap.set('n', '[b', '<cmd>bprev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = 'Next buffer' })

-- Center after scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move selected lines up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

