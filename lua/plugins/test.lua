-- Language-specific test adapters for test.core's neotest (see lua/config/lazy.lua).
-- No official LazyVim extra bundles these, so wired up directly following the
-- same opts.adapters convention LazyVim's own lang extras use.
--
-- JS/TS: no adapter wired up. Both neotest-jest and neotest-vitest have the same
-- unfixed upstream Windows bug: they build the result-matching key straight from
-- the raw, backslash-separated path returned by their test runner's JSON reporter,
-- while neotest's own position IDs are forward-slash normalized
-- (vim.fs.normalize(pos.path)) - the two never match on Windows.
--   - neotest-jest (lua/neotest-jest/init.lua, util.escapeTestPattern): forward-slashes
--     the path before using it as a Jest --testPathPattern regex, which then matches
--     nothing against Jest's own native Windows paths -> every run fails, "0 matches".
--   - neotest-vitest (lua/neotest-vitest/util.lua): has a sanitize() helper that fixes
--     this exact case (backslash -> forward-slash, drive-letter casing) but it's
--     defined and never called from parsed_json_to_results() - confirmed on the
--     latest commit (c3c6971, 2026-07-13) by running a real 1-pass/1-fail vitest
--     file end-to-end via <leader>tt: vitest itself reports 1 passed/1 failed
--     (`npx vitest run`), but neotest reports both as failed, on both vitest v4.1
--     and v1.x.
-- Revisit either adapter if upstream fixes the path handling. Until then, run
-- `npx vitest`/`npx jest` directly in a terminal for JS/TS tests.
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {},
      },
    },
  },
}
