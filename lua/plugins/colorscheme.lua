-- Catppuccin Mocha: one of the most widely adopted dark themes across the
-- JS/TS, Python, .NET, and Lua communities, with actively maintained
-- treesitter/LSP semantic-token support for all of them.
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        blink_cmp = true,
        mason = true,
        which_key = true,
        treesitter_context = true,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
