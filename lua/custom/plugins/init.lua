return {
  -- Productivity: File navigation
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    },
  },

  -- Productivity: Better motion
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
    },
  },

  -- UI: Better picking and 10x developer snacks
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = {
        enabled = true,
        -- Disable vertical indent lines if they cause issues on Windows
        -- (often related to 'char' rendering in certain terminals)
        char = '│', -- Solid vertical line
        scope = {
          enabled = true,
          char = '┃', -- Thicker line for scope
        },
      },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        -- Picker layout fixes for Windows Terminal
        layout = {
          -- Use simple border if rounded/complex looks broken
          preset = 'default',
        },
      },
      quickfix = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { '<leader>sp', function() Snacks.picker() end, desc = 'Snacks [P]icker' },
      { '<leader>ff', function() Snacks.picker.files() end, desc = '[F]ind [F]iles' },
      { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch [G]rep' },
      { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
      { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
      { '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
      { '<leader>bd', function() Snacks.bufdelete() end, desc = '[B]uffer [D]elete' },
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'LazyGit' },
    },
  },

  -- Git: Better blame and diffs
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = '[G]it [D]iff' },
    },
  },

  -- Coding: Auto-pair brackets (Community Standard)
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Coding: Auto-close and auto-rename HTML tags (Important for React/Angular)
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  -- Coding: Enhanced Yank/Paste history
  {
    'gbprod/yanky.nvim',
    opts = {
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 200,
      },
    },
    keys = {
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put after' },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put before' },
      { '<leader>sy', function() Snacks.picker.grep({ prompt = "Yank History", cmd = "YankyList" }) end, desc = '[S]earch [Y]ank History' },
    },
  },

  -- Language Support: Web Development (Typescript/Angular/React)
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  },

  -- Web Dev: Color Highlighter
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      user_default_options = {
        names = false,
        mode = 'virtualtext',
        virtualtext = '■',
      },
    },
  },
}

