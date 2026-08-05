-- Language-specific debug adapters for dap.core (see lua/config/lazy.lua).
-- Mirrors LazyVim's own lang.python/lang.typescript DAP wiring, trimmed down
-- since our custom python.lua/typescript.lua don't pull in those full extras.
-- Both adapters are Mason-managed executables, so this is OS-independent.
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "mfussenegger/nvim-dap-python",
        -- stylua: ignore
        keys = {
          { "<leader>dPt", function() require("dap-python").test_method() end, desc = "Debug Method", ft = "python" },
          { "<leader>dPc", function() require("dap-python").test_class() end, desc = "Debug Class", ft = "python" },
        },
        config = function()
          -- Mason's "debugpy-adapter" shim on Windows is a .CMD wrapper
          -- around the venv's python.exe. Spawning a stdio-based DAP adapter
          -- through cmd.exe (rather than the real executable directly) can
          -- break the raw stdio protocol framing under libuv - point at the
          -- venv's python.exe directly instead, which is a plain, well
          -- supported "python -m debugpy.adapter" launch on every OS.
          local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
          local python_path = "python3"
          if mason_registry_ok and mason_registry.is_installed("debugpy") then
            local install_path = mason_registry.get_package("debugpy"):get_install_path()
            local venv_python = vim.fn.has("win32") == 1 and (install_path .. "/venv/Scripts/python.exe")
              or (install_path .. "/venv/bin/python")
            if vim.fn.filereadable(venv_python) == 1 then
              python_path = venv_python
            end
          end
          require("dap-python").setup(python_path)
        end,
      },
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
    },
    opts = function()
      local dap = require("dap")

      for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
        local pwaType = "pwa-" .. adapterType

        if not dap.adapters[pwaType] then
          -- Same libuv/PATHEXT caveat as debugpy-adapter below: resolve the
          -- full .CMD path so Windows can actually spawn Mason's shim.
          local js_debug_adapter = vim.fn.exepath("js-debug-adapter")
          dap.adapters[pwaType] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
              command = js_debug_adapter ~= "" and js_debug_adapter or "js-debug-adapter",
              args = { "${port}" },
            },
          }
        end

        if not dap.adapters[adapterType] then
          dap.adapters[adapterType] = function(cb, config)
            local nativeAdapter = dap.adapters[pwaType]
            config.type = pwaType
            if type(nativeAdapter) == "function" then
              nativeAdapter(cb, config)
            else
              cb(nativeAdapter)
            end
          end
        end
      end

      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      local vscode = require("dap.ext.vscode")
      vscode.type_to_filetypes["node"] = js_filetypes
      vscode.type_to_filetypes["pwa-node"] = js_filetypes

      for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then
          local runtimeExecutable = nil
          if language:find("typescript") then
            runtimeExecutable = vim.fn.executable("tsx") == 1 and "tsx" or "ts-node"
          end
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              runtimeExecutable = runtimeExecutable,
              skipFiles = { "<node_internals>/**", "node_modules/**" },
              resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              runtimeExecutable = runtimeExecutable,
              skipFiles = { "<node_internals>/**", "node_modules/**" },
              resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
            },
          }
        end
      end
    end,
  },

  -- Don't let mason-nvim-dap fight nvim-dap-python/js-debug-adapter's own setup
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      automatic_installation = { exclude = { "chrome" } },
      handlers = {
        python = function() end,
      },
    },
  },
}
