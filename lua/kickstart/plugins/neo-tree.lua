-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
---@module 'lazy'
---@type LazySpec
return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim'},
    lazy = false,
    keys = {{
        '<leader>e',
        ':Neotree toggle<CR>',
        desc = 'NeoTree toggle',
        silent = true
    }, {
        '\\',
        ':Neotree reveal<CR>',
        desc = 'NeoTree reveal',
        silent = true
    }},
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
        window = {
            auto_expand_width = true,
            mappings = {
                -- Show full path in a notification popup (floating)
                ['zh'] = function(state)
                    local node = state.tree:get_node()
                    vim.notify(node.path, vim.log.levels.INFO, {
                        title = 'Path'
                    })
                end
            }
        },
        filesystem = {
            use_libuv_file_watcher = true,
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false
            },
            group_empty_dirs = true, -- optional: groups empty folders
            follow_current_file = {
                enabled = true
            },
            window = {
                mappings = {
                    ['\\'] = 'close_window'
                }
            }
        },
        default_component_configs = {
            container = {
                enable_character_fade = true
            },
            last_modified = {
                enabled = false -- Disable last modified to save space
            },
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = '',
                expander_expanded = '',
                expander_highlight = 'NeoTreeExpander'
            }
        }
    }
}
