return {
    'rmagatti/auto-session',
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        log_level = 'error',
        auto_restore_last_session = false,

        -- Session lens configuration for easy searching
        session_lens = {
            -- Use Snacks picker if available
            load_on_setup = true,
            picker_opts = {
                border = true,
            },
            previewer = false,
        },
    },
    config = function(_, opts)
        -- Recommended sessionoptions for better restoration
        vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

        require('auto-session').setup(opts)

        -- Keymaps for session management
        vim.keymap.set('n', '<leader>ws', '<cmd>AutoSession search<CR>', {
            desc = '[W]orkspace [S]ession search'
        })
        vim.keymap.set('n', '<leader>wS', '<cmd>AutoSession save<CR>', {
            desc = '[W]orkspace [S]ession save'
        })
        vim.keymap.set('n', '<leader>wa', '<cmd>AutoSession toggle<CR>', {
            desc = '[W]orkspace toggle [A]utosave'
        })
    end
}
