-- YAML support. Uses LazyVim's own yaml extra (SchemaStore.nvim auto-detects
-- most schemas), plus the two explicit schema mappings the old config pinned
-- by hand for a Kubernetes manifests folder and GitHub Actions workflows.
return {
  { import = "lazyvim.plugins.extras.lang.yaml" },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "k8s/*.yaml",
              },
            },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        yaml = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
