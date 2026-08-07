-- YAML support. The lang.yaml extra itself is imported in lua/config/lazy.lua
-- (SchemaStore.nvim auto-detects most schemas); this file just adds the two
-- explicit schema mappings the old config pinned by hand for a Kubernetes
-- manifests folder and GitHub Actions workflows.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                -- yannh's mirror, not the instrumenta one the old config pinned:
                -- instrumenta has been archived since 2021 and its newest schema
                -- is Kubernetes v1.18, which misvalidates anything using an
                -- apiVersion or field added in the six years since.
                ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.36.0-standalone-strict/all.json"] = "k8s/*.yaml",
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
