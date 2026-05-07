

return {{ -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    enabled = true,
    event = 'VimEnter',
    dependencies = {'nvim-lua/plenary.nvim', {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end
    }, {'nvim-telescope/telescope-ui-select.nvim'}, {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font
    }},
    config = function()
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = {'node_modules', '%.git[\\/]', '.angular[\\/]', 'dist[\\/]', 'build[\\/]',
                                        'target[\\/]', '%.ipynb'}
            },
            pickers = {
                find_files = {
                    hidden = true,
                    -- Use fd to find files, but exclude .git while keeping other hidden files
                    find_command = {"fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", ".git"}
                }
            },
            extensions = {
                ['ui-select'] = {require('telescope.themes').get_dropdown()}
            }
        }

        -- Enable Telescope extensions if they are installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        -- See `:help telescope.builtin`
        local builtin = require 'telescope.builtin'
        
        -- Community Standard Find Mappings
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Find Files (Root)' })
        vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find Files (Alt)' })
        
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
        vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = '[/] Grep Project' })
        
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
        vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = '[,] Switch Buffers' })
        
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]ind [R]ecent' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
        
        -- Search prefix kept for specific lookups
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
        vim.keymap.set({'n', 'v'}, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })

        -- Telescope LSP mappings (LspAttach)
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('telescope-lsp-attach', {
                clear = true
            }),
            callback = function(event)
                local buf = event.buf
                vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
                vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
                vim.keymap.set('n', 'gI', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
                vim.keymap.set('n', 'gy', builtin.lsp_type_definitions, { buffer = buf, desc = 'Type [D]efinition' })
                vim.keymap.set('n', '<leader>cs', builtin.lsp_document_symbols, { buffer = buf, desc = '[C]ode [S]ymbols' })
                
                -- Keep new defaults as alternates
                vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = 'LSP references' })
                vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = 'LSP implementations' })
                vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = 'LSP definitions' })
            end
        })

        -- Theme override
        vim.keymap.set('n', '<leader>sb', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false
            })
        end, {
            desc = '[/] Fuzzily search in current buffer'
        })

        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files'
            }
        end, {
            desc = '[S]earch [/] in Open Files'
        })

        vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files {
                cwd = vim.fn.stdpath 'config'
            }
        end, {
            desc = '[S]earch [N]eovim files'
        })
    end
}}
