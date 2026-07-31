-- Matches the old setup's minimal Python support: just pyright, nothing else
-- (no venv-selector/debugpy/ruff - none of that was in the old config either).
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
      },
    },
  },
}
