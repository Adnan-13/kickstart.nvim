-- Python: pyright for types/navigation, ruff for linting + formatting.
-- Deliberately NOT importing LazyVim's lang.python extra (it also drags in
-- venv-selector and its own neotest/DAP wiring, which lua/plugins/test.lua and
-- lua/plugins/dap.lua already handle here).
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
      },
      setup = {
        -- pyright owns hover/types; ruff would otherwise return a second,
        -- much thinner hover response and race pyright for the popup.
        ruff = function()
          Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
            client.server_capabilities.hoverProvider = false
          end)
        end,
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "ruff" } },
  },

  -- Point pyright at an interpreter per project (<leader>cv). Repos here
  -- declare dependencies in pyproject.toml but run them in Docker, so there is
  -- no venv beside the source and pyright resolves local modules while every
  -- third-party import (fastapi, structlog, ...) comes back unresolved. Picking
  -- the interpreter once per project fixes goto-definition/hover for them.
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    ft = "python",
    opts = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
    keys = { { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },

  -- Formatting goes through conform (same as the prettierd setup in
  -- typescript.lua) rather than the LSP, so `ruff format` is invoked directly
  -- and import sorting can run as an explicit first pass.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
}
