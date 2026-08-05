-- Language-specific test adapters for test.core's neotest (see lua/config/lazy.lua).
-- No official LazyVim extra bundles these, so wired up directly following the
-- same opts.adapters convention LazyVim's own lang extras use.
--
-- JS/TS: only neotest-vitest, not neotest-jest. Verified end-to-end: vitest
-- runs, reports pass/fail, and shows diagnostics correctly. neotest-jest's
-- spec() unconditionally forward-slashes the test file path before handing it
-- to Jest as a --testPathPattern regex argument (lua/neotest-jest/init.lua,
-- `util.escapeTestPattern(vim.fs.normalize(pos.path))`), but current Jest
-- versions match that regex against Windows' native backslash paths, so it
-- always resolves to "0 matches" and every run fails - a real upstream
-- Windows regression with no config-level workaround (not exposed via
-- jestArguments/jestCommand). Revisit if upstream fixes it.
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {},
        ["neotest-vitest"] = {},
      },
    },
  },
}
