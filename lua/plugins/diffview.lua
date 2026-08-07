return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "[G]it [D]iff" },
    },
  },

  -- The snacks_picker extra binds <leader>gd to Snacks.picker.git_diff. snacks
  -- loads during startup and sets its own keymaps, overwriting diffview's
  -- lazy-load stub, so <leader>gd opened the hunks picker and DiffviewOpen was
  -- unreachable (diffview never even loaded). Give <leader>gd back to diffview
  -- and move the hunks picker to <leader>gh, which is otherwise unused.
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gd", false },
      -- stylua: ignore
      { "<leader>gh", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
    },
  },
}
