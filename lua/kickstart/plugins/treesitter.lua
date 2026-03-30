---@module 'lazy'
---@type LazySpec
return {{
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    opts = {
        ensure_installed = {'angular', 'bash', 'c', 'diff', 'html', 'javascript', 'jsdoc', 'json', 'lua', 'luadoc',
                            'markdown', 'markdown_inline', 'query', 'typescript', 'tsx', 'vim', 'vimdoc', 'yaml', 'css',
                            'scss', 'jsonc'},
        auto_install = true,
        highlight = {
            enable = true,
            -- Disable regex highlighting entirely - this ensures ONLY treesitter is used
            additional_vim_regex_highlighting = false
        },
        indent = {
            enable = true,
            disable = {'ruby'}
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<C-space>',
                node_incremental = '<C-space>',
                scope_incremental = false,
                node_decremental = '<bs>'
            }
        }
    },
    config = function(_, opts)
        if vim.fn.has 'win32' == 1 then
            require('nvim-treesitter.install').compilers = {'gcc', 'clang', 'zig'}
        end
        require('nvim-treesitter.install').prefer_git = true
        require('nvim-treesitter.config').setup(opts)
    end
}}
