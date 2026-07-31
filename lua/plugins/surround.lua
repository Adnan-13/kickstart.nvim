-- mini.surround isn't enabled by LazyVim's core config, only via this extra.
return {
  { import = "lazyvim.plugins.extras.coding.mini-surround" },

  -- Remap from the default `gs*` prefix to a leader-driven menu.
  -- NOTE: intentionally `<leader>S` (capital), not `<leader>s` — LazyVim's own
  -- which-key spec already reserves lowercase `<leader>s` for "search" (grep,
  -- diagnostics, grug-far's `<leader>sr`, todo-comments' `<leader>st`, etc.),
  -- so reusing it here would silently shadow those instead of adding a menu.
  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "<leader>Sa", -- Add surrounding in Normal and Visual modes
        delete = "<leader>Sd", -- Delete surrounding
        find = "<leader>Sf", -- Find surrounding (to the right)
        find_left = "<leader>SF", -- Find surrounding (to the left)
        highlight = "<leader>Sh", -- Highlight surrounding
        replace = "<leader>Sr", -- Replace surrounding
        update_n_lines = "<leader>Sn", -- Update `n_lines`
      },
    },
  },

  -- Label the new group in the which-key popup (opts_extend merges spec
  -- entries across plugin files, so this appends rather than overwriting).
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>S", group = "surround", mode = { "n", "x" } },
      },
    },
  },
}
