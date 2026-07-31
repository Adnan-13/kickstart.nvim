# Copilot Instructions

The canonical agent instructions for this repo live in
[`AGENTS.md`](../AGENTS.md) at the repository root — read and follow it.
The rules below are duplicated here so they apply even in contexts that
don't resolve the link above; keep them in sync with `AGENTS.md` if either
changes.

## Commit Messages

Use the **Conventional Commits** format: `<type>(<scope>): <description>`

- **Types**: `feat`, `fix`, `refactor`, `style`, `docs`, `perf`, `chore`
- **Title**: first line under 50 characters, lowercase after the colon, no trailing period
- **Body**: blank line after the title, wrapped at 72 characters, `-` bullet points for multiple changes
- Wrap the final commit message in a triple-backtick code block for easy copying
