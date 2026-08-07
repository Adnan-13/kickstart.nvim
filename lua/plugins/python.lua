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
