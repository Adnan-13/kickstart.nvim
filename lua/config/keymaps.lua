-- [[ Keymaps ]]

-- Exit term mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Quick save & Quit
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Quick [w]rite' })
vim.keymap.set('n', '<leader>fs', '<cmd>w<CR>', { desc = '[F]ile [S]ave' })
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save File' })
vim.keymap.set('n', '<leader>qq', '<cmd>qa<CR>', { desc = '[Q]uit [Q]all' })

-- Clear highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>nh', '<cmd>nohlsearch<CR>', { desc = '[N]o [H]ighlight' })

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to Right window' })

-- Buffer navigation
vim.keymap.set('n', 'H', '<cmd>bprev<CR>', { desc = 'Prev Buffer' })
vim.keymap.set('n', 'L', '<cmd>bnext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '[b', '<cmd>bprev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = '[B]uffer [D]elete' })

-- Center after scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move selected lines up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Explorer toggle (assuming nvim-tree or neo-tree is used, default to Lexplore)
vim.keymap.set('n', '<leader>e', '<cmd>Lex 30<CR>', { desc = '[E]xplorer' })

-- Fast Yank/Paste (Improved)
vim.keymap.set('n', '<leader>ya', ':%y+<CR>', { desc = '[Y]ank [A]ll' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from Clipboard' })

