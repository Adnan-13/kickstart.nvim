---@module 'lazy'
---@type LazySpec
return {{
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
        require('tokyonight').setup {
            style = 'night',
            transparent = false,
            terminal_colors = true,
            styles = {
                comments = {
                    italic = true
                },
                keywords = {
                    italic = true
                },
                functions = {},
                variables = {},
                sidebars = 'dark',
                floats = 'dark'
            },
            on_highlights = function(hl, c)
                hl.LspReferenceText = {
                    bg = c.fg_gutter,
                    bold = true
                }
                hl.LspReferenceRead = {
                    bg = c.fg_gutter,
                    bold = true
                }
                hl.LspReferenceWrite = {
                    bg = c.fg_gutter,
                    bold = true
                }

                -- Force high-contrast highlights for JS/TS
                hl['@keyword'] = {
                    fg = c.purple,
                    italic = true,
                    bold = true
                }
                hl['@keyword.modifier'] = {
                    fg = c.magenta,
                    bold = true
                } -- For 'const', 'export', 'static'
                hl['@keyword.type'] = {
                    fg = c.yellow,
                    bold = true
                } -- For 'void', 'string', etc.
                hl['@type'] = {
                    fg = c.yellow,
                    bold = true
                }
                hl['@variable'] = {
                    fg = c.fg
                }
                hl['@variable.member'] = {
                    fg = c.cyan
                } -- Properties/members distinct
                hl['@function'] = {
                    fg = c.blue,
                    bold = true
                }
                hl['@comment'] = {
                    fg = c.comment,
                    italic = true
                }
                hl['@string'] = {
                    fg = c.green
                }
                hl['@keyword.function'] = {
                    fg = c.magenta,
                    italic = true,
                    bold = true
                }
            end
        }
        vim.cmd.colorscheme 'tokyonight-night'
    end
}}
