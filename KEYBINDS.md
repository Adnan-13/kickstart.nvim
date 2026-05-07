# Neovim Community Keybinds Cheatsheet

This cheatsheet follows the **LazyVim/Modern** community standards while maintaining common Neovim/Vim defaults.

## 📂 Navigation & Files
| Action | Keybind | Notes |
| :--- | :--- | :--- |
| **Find Files** | `<leader>ff` or `<leader><space>` | LazyVim standard for root file search. |
| **Quick Switch File** | `<C-p>` | Universal muscle memory for file searching. |
| **Recent Files** | `<leader>fr` | `[F]ind [R]ecent`. |
| **Find Buffers** | `<leader>fb` or `<leader>,` | `,` is extremely fast for buffer switching. |
| **File Explorer** | `<leader>e` | Toggle file explorer tree. |
| **Save File** | `<leader>fs` or `<leader>w` or `<C-s>` | Multiple ways to save quickly. |
| **Quit All** | `<leader>qq` | `[Q]uit [Q]all`. |

## 🔍 Search & Grep (Telescope)
| Action | Keybind | Notes |
| :--- | :--- | :--- |
| **Global Search** | `<leader>fg` or `<leader>/` | `/` is standard for "Find in Project". |
| **Search Word** | `<leader>sw` | Search current word under cursor. |
| **Find Help** | `<leader>fh` | `[F]ind [H]elp`. |
| **Diagnostics** | `<leader>sd` | `[S]earch [D]iagnostics`. |
| **Clear Highlight** | `<leader>nh` or `<Esc>` | `[N]o [H]ighlight`. |

## 🛠️ LSP & Coding
| Action | Keybind | Notes |
| :--- | :--- | :--- |
| **Code Action** | `<leader>ca` | Universal standard (alternate: `gra`). |
| **Rename Symbol** | `<leader>rn` | `[R]e[n]ame` standard (alternate: `grn`). |
| **Format Buffer** | `<leader>cf` | `[C]ode [F]ormat`. |
| **Goto Definition**| `gd` | Opens in Telescope for preview (alternate: `grd`). |
| **Goto References**| `gr` | Opens list in Telescope (alternate: `grr`). |
| **Implementation** | `gI` | `[G]oto [I]mplementation`. |
| **Symbols (Doc)** | `<leader>cs` | `[C]ode [S]ymbols`. |
| **Hover Help** | `K` | Default Neovim hover documentation. |

## 🖥️ Window & Buffer Management
| Action | Keybind | Notes |
| :--- | :--- | :--- |
| **Focus Left** | `<C-h>` | Universal window navigation. |
| **Focus Down** | `<C-j>` | Universal window navigation. |
| **Focus Up** | `<C-k>` | Universal window navigation. |
| **Focus Right** | `<C-l>` | Universal window navigation. |
| **Next Buffer** | `L` | Shift+L is the fastest way to switch tabs/buffers. |
| **Prev Buffer** | `H` | Shift+H for the left side. |
| **Delete Buffer** | `<leader>bd` | `[B]uffer [D]elete`. |

## 📝 Miscellaneous
| Action | Keybind | Notes |
| :--- | :--- | :--- |
| **Move Line Up** | `K` (Visual mode) | Move selected lines up. |
| **Move Line Down** | `J` (Visual mode) | Move selected lines down. |
| **Exit Terminal** | `<Esc><Esc>` | Easy exit from built-in `:term`. |
| **Center Screen** | `<C-d>` / `<C-u>` | Automatically centers (`zz`) after half-page scroll. |

---
*Tip: Use `<leader>?` or `:Telescope keymaps` to discover more bindings live.*

## 🚀 Vim/Neovim Movement & Editing (The Fundamentals)

### 🏎️ Vertical Movement
| Action | Keybind | Notes |
| :--- | :--- | :--- |
| **Beginning of File** | `gg` | Jump to the very first line. |
| **End of File** | `G` | Jump to the very last line. |
| **Half Page Down** | `<C-d>` | Centers automatically (`zz`). |
| **Half Page Up** | `<C-u>` | Centers automatically (`zz`). |
| **Go to Line Number** | `:[number]` | Example: `:50` to go to line 50. |
| **Matching Pair** | `%` | Jump between matching `()`, `[]`, or `{}`. |

### 🏎️ Horizontal Movement
| Action | Keybind | Notes |
| :--- | :--- | :--- |
| **Beginning of Line** | `0` | Hard start of line. |
| **First Non-blank Char**| `^` | Start of actual code on line. |
| **End of Line** | `$` | Jump to the end of the line. |
| **Next Word** | `w` | Jump to start of next word. |
| **Back a Word** | `b` | Jump back to start of word. |
| **End of Word** | `e` | Jump to the end of the word. |
| **Find Character** | `f[char]` | Jump forward to a specific character (e.g., `f(`). |
| **Find Backwards** | `F[char]` | Jump backwards to a specific character. |

### ✍️ Editing & Selection
| Action | Keybind | Notes |
| :--- | :--- | :--- |
| **Select All** | `ggVG` | Select every line in the file. |
| **Inside Scope/Block** | `vi{` | Visually select everything inside `{}`. |
| **Around Scope/Block**| `va{` | Select inside `{}` AND the braces themselves. |
| **Delete Inside Scope**| `di{` | Delete everything inside `{}` (keep braces). |
| **Change Inside Scope**| `ci{` | Delete inside `{}` and enter Insert mode. |
| **Replace Character** | `r[char]` | Replace single character under cursor. |
| **Delete Line** | `dd` | Cut/Delete current line. |
| **Undo** | `u` | Undo last action. |
| **Redo** | `<C-r>` | Redo last undone action. |

### 📋 Copy/Paste (Yank/Put)
| Action | Keybind | Notes |
| :--- | :--- | :--- |
| **Yank (Copy)** | `y` | Works with movements. Syncs to System Clipboard. |
| **Yank All** | `<leader>ya` | Copy the entire file to system clipboard. |
| **Paste after** | `p` | Standard paste. Cleaned of Windows `^M` characters. |
| **Paste before** | `P` | Paste before cursor. Cleaned of Windows `^M` characters. |

---
*Tip: Your clipboard is optimized to prefer `win32yank.exe` for speed and to strip carriage returns (`^M`).*

| **Paste before**| `P` | Paste before cursor. |
| **System Sync** | (Auto) | `y` and `p` now automatically use the System Clipboard. |
| **Fast Yank All**| `<leader>ya` | Yank entire file. |
| **Fast Paste**| `<leader>p` | Paste from system clipboard explicitly. |
