-- TypeScript/Angular/React stack. Deliberately NOT importing LazyVim's own
-- `lazyvim.plugins.extras.lang.typescript` extra (which sets up ts_ls/vtsls) -
-- typescript-tools.nvim replaces that LSP entirely, same as the old config.
return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local is_angular = lspconfig.util.root_pattern("angular.json", "nx.json")

      require("typescript-tools").setup(vim.tbl_deep_extend("force", opts, {
        -- Angular projects use angularls (below) to handle TS instead
        on_attach = function(client, bufnr)
          if is_angular(vim.api.nvim_buf_get_name(bufnr)) then
            client.stop()
          end
        end,
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          expose_as_code_action = "all",
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          disable_member_code_lens = true,
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      }))
    end,
  },

  -- Auto-close/rename HTML/JSX tags
  { "windwp/nvim-ts-autotag", opts = {} },

  -- Angular's own LSP, only started in actual Angular/Nx projects
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          root_dir = function(bufnr, on_dir)
            local root = require("lspconfig.util").root_pattern("angular.json", "nx.json")(vim.api.nvim_buf_get_name(bufnr))
            if root then
              on_dir(root)
            end
          end,
        },
      },
    },
  },

  -- Extra treesitter parsers for the web/Angular stack
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "angular",
        "jsdoc",
        "jsonc",
        "regex",
        "svelte",
        "vue",
        "css",
        "scss",
      })
    end,
  },

  -- Ensure mason actually installs prettierd - configuring conform to use it
  -- (below) isn't enough on its own, mason needs it in ensure_installed too.
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettierd" } },
  },

  -- Formatting to match the old prettier setup (4-space, single quotes, etc.)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        angular = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        prettier = {
          prepend_args = {
            "--tab-width",
            "4",
            "--single-quote",
            "--jsx-single-quote",
            "--single-attribute-per-line",
            "--no-bracket-spacing",
          },
        },
        prettierd = {
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.prettierrc.json"),
          },
        },
      },
    },
  },
}
