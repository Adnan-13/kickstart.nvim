# Agent Instructions

Personal Neovim configuration based on kickstart.nvim. See `README.md` for
setup/installation and `KEYBINDS.md` for the keybinding reference.

This file is the canonical, cross-tool instructions file for every AI
coding agent working in this repo (Cursor, GitHub Copilot, Claude Code,
etc). `.github/copilot-instructions.md` and `CLAUDE.md` exist only as
bridges for tools that don't read `AGENTS.md` natively — edit the rules
here, not there, so the two stay in sync automatically.

## Commit Messages

Use the **Conventional Commits** format: `<type>(<scope>): <description>`

- **Types**: `feat`, `fix`, `refactor`, `style`, `docs`, `perf`, `chore`
- **Scope**: optional, usually the plugin or area touched (e.g. `feat(blink): ...`)
- **Title**: first line under 50 characters, lowercase after the colon, no trailing period
- **Body**: blank line after the title, wrapped at 72 characters, `-` bullet points for multiple changes
- Wrap the final commit message in a triple-backtick code block for easy copying

Example:

```
feat(blink): switch keymap to super-tab preset

- replace default preset with super-tab for tab-driven completion
```
