

return {{ -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {{
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                return
            end
            return 'make install_jsregexp'
        end)(),
        opts = {}
    }},


    opts = {
        keymap = {
            preset = 'default'
        },
        appearance = {
            nerd_font_variant = 'mono'
        },
        completion = {
            documentation = {
                auto_show = false,
                auto_show_delay_ms = 500
            },
            menu = {
                draw = {
                    columns = {
                        { 'label', 'label_description', gap = 1 },
                        { 'kind_icon', 'kind' },
                    },
                },
            },
        },
        cmdline = {
            enabled = false
        },
        sources = {
            default = {'lsp', 'path', 'snippets'}
        },
        snippets = {
            preset = 'luasnip'
        },
        fuzzy = {
            implementation = 'prefer_rust'
        },
        signature = {
            enabled = true
        }
    }
}}
