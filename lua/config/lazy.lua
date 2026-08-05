local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- LazyVim extras must be imported here (top-level, after lazyvim.plugins and
    -- before your own plugins) - importing them from inside lua/plugins/*.lua
    -- files instead triggers LazyVim's own "import order incorrect" warning.
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.ai.copilot" },
    -- Harpoon: pin/jump between a small working set of files (<leader>H*)
    { import = "lazyvim.plugins.extras.editor.harpoon2" },
    -- Sticky function/class header pinned at the top while scrolling
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    -- Live-preview LSP rename (:IncRename) across all occurrences
    { import = "lazyvim.plugins.extras.editor.inc-rename" },
    -- Smarter <C-a>/<C-x> increment-decrement (dates, booleans, semver, ...)
    { import = "lazyvim.plugins.extras.editor.dial" },
    -- Adds :StartupTime to profile plugin load time
    { import = "lazyvim.plugins.extras.util.startuptime" },
    -- Symbols outline sidebar (<leader>cs)
    { import = "lazyvim.plugins.extras.editor.aerial" },
    -- Highlight other references to the word under the cursor ([[ / ]])
    { import = "lazyvim.plugins.extras.editor.illuminate" },
    -- Lua-native task runner (<leader>ow/oo/ot)
    { import = "lazyvim.plugins.extras.editor.overseer" },
    -- Extract func/var, inline var, debug print (<leader>r*)
    { import = "lazyvim.plugins.extras.editor.refactoring" },
    -- REST client for .http files (<leader>R*)
    { import = "lazyvim.plugins.extras.util.rest" },
    -- Dockerfile/compose LSP (dockerls, docker-compose) + hadolint linting
    { import = "lazyvim.plugins.extras.lang.docker" },
    -- Docstring/annotation generator from function signatures (<leader>cn)
    { import = "lazyvim.plugins.extras.coding.neogen" },
    -- Explicit snacks-based picker (already the effective default; octo.nvim
    -- below requires one of the picker extras to be enabled, not just present)
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    -- Manage GitHub issues/PRs from inside Neovim (<leader>gi/gp/gr/...)
    { import = "lazyvim.plugins.extras.util.octo" },
    -- SQL: dadbod DB client/completion/UI (<leader>D), sqlfluff lint/format
    { import = "lazyvim.plugins.extras.lang.sql" },
    -- Debug Adapter Protocol core (nvim-dap, dap-ui, mason-nvim-dap): <leader>d*
    -- Python/JS-TS adapters are configured in lua/plugins/dap.lua
    { import = "lazyvim.plugins.extras.dap.core" },
    -- Test runner core (neotest): <leader>t*
    -- Python/JS-TS adapters are configured in lua/plugins/test.lua
    { import = "lazyvim.plugins.extras.test.core" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
