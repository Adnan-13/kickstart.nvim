return {
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    opts = {
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 200,
      },
    },
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
    },
  },
}
