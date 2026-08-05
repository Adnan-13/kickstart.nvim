-- Snacks explorer (LazyVim's default file sidebar, <leader>e) hides dotfiles
-- and gitignored files/folders by default. Show both always; toggle back off
-- per-session with H (hidden) / I (ignored) inside the explorer if needed.
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
}
