-- C#/.NET. Deliberately NOT LazyVim's lang.dotnet extra: that wires up
-- omnisharp, which Microsoft has discontinued in favour of the Roslyn language
-- server now shipped with the VS Code C# extension. These solutions are large
-- (30+ repos, net8.0/netstandard2.0), which is exactly where omnisharp drags.
--
-- LSP + formatting only - no netcoredbg/neotest-vstest, since debugging and
-- test running for .NET happen in Visual Studio/Rider rather than here.
return {
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {},
  },

  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "roslyn-language-server", "csharpier" } },
  },

  -- nvim-lspconfig also ships a `roslyn_ls` config, and mason-lspconfig enables
  -- it automatically once the Mason package is installed. Left alone that runs
  -- a second Microsoft.CodeAnalysis.LanguageServer over the same solution -
  -- measured at 305 MB + 562 MB side by side on Rethink.BH.Clinical. Let
  -- roslyn.nvim own the client.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        roslyn_ls = { enabled = false },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
    },
  },
}
