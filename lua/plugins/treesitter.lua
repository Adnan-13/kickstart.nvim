return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- tree-sitter-gitcommit's pinned grammar revision ships a tree-sitter.json
      -- that references src/scanner.c, but that file isn't present in the
      -- generated sources - this is an upstream grammar/CLI metadata mismatch,
      -- not something fixable by switching C compilers (reproduces with zig,
      -- gcc, and cl). Drop it from ensure_installed so :checkhealth and every
      -- startup don't keep retrying (and failing) a doomed compile. Only cost
      -- is no treesitter highlighting for gitcommit buffers.
      opts.ensure_installed = vim.tbl_filter(function(lang)
        return lang ~= "gitcommit"
      end, opts.ensure_installed or {})
    end,
  },
}
