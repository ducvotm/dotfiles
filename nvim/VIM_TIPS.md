# Vim Productivity Tips for Java Developers

A comprehensive guide to essential Vim/Neovim techniques that boost productivity in Java development workflows.

## Table of Contents

1. [Diagnostic & Error Management](#diagnostic--error-management)
2. [File Navigation](#file-navigation)
3. [LSP Operations](#lsp-operations)
4. [Code Manipulation](#code-manipulation)
5. [Terminal Integration](#terminal-integration)
6. [Help System](#help-system)

---

## Diagnostic & Error Management

When working with large Java files, managing compilation errors and warnings efficiently is crucial.

### Show Full Diagnostic Message

**Keybinding:** `<leader>e`

Sometimes error messages are truncated in the status line. Use this to display the full diagnostic in a floating window.

```lua
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
```

### Copy Error Message

**Keybinding:** `<leader>ce`

Quickly copy the full error/warning message to clipboard for searching or sharing.

```lua
vim.keymap.set('n', '<leader>ce', function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics > 0 then
    local message = diagnostics[1].message
    vim.fn.setreg('+', message)
    print('Copied: ' .. message)
  end
end, { desc = '[C]opy [E]rror message' })
```

### Navigate Between Errors

**Keybindings:**
- `]e` - Next error/warning
- `[e` - Previous error/warning

Jump quickly between diagnostics in long files without scrolling.

```lua
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Go to next [E]rror' })
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Go to previous [E]rror' })
```

**Use Case:** In a 1000+ line service class with multiple validation errors, quickly jump between issues instead of scrolling.

---

## File Navigation

Efficient file navigation is essential for Java projects with deep package structures.

### Find Files in Project

**Keybinding:** `<leader>ff`

Search for files by name in your project (respects `.gitignore`).

```lua
require('telescope.builtin').find_files()
```

**Use Case:** Quickly open `UserService.java` without navigating through `src/main/java/com/example/service/`

### Find Hidden Files

**Keybinding:** `<leader>pf`

Search for hidden files like `.env`, `.gitignore`, or configuration files in your project.

```lua
require('telescope.builtin').find_files({ hidden = true })
```

### Grep in Files

**Keybinding:** `<leader>fg`

Search for text content across all files in the project. Preview results before jumping.

```lua
require('telescope.builtin').live_grep()
```

**Use Case:** Find all usages of "saveEvent" across your codebase, including in comments and strings.

**Requirements:** Install `ripgrep` for fast text searching:
```bash
brew install ripgrep  # macOS
```

### Recent Buffers

**Keybinding:** `<leader>fb`

Show list of recently opened files with buffer numbers. Quick way to return to previous files.

```lua
require('telescope.builtin').buffers()
```

**Alternative:** Use `ctrl-^` to toggle between current and previous file.

### File Marking with Harpoon

Mark frequently accessed files for instant navigation, especially useful when working across multiple classes.

**Keybindings:**
- `<Tab>s` - Show marked files
- `<Tab>a` - Add current file to marks
- `<Tab>[` - Previous marked file
- `<Tab>]` - Next marked file
- `1-9` in harpoon menu - Jump to specific mark

**Setup:**
```lua
local harpoon = require('harpoon')
vim.keymap.set('n', '<Tab>s', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set('n', '<Tab>a', function() harpoon:list():add() end)
vim.keymap.set('n', '<Tab>[', function() harpoon:list():prev() end)
vim.keymap.set('n', '<Tab>]', function() harpoon:list():next() end)
```

**Use Case:** Mark `UserController.java`, `UserService.java`, and `UserRepository.java` for quick switching while implementing a feature.

**Note:** Each tmux session maintains its own harpoon list, preventing conflicts between projects.

### Mark Lines Within a File

When debugging or working in large files, mark specific lines of interest.

**Keybindings:**
- `m` - Mark current line
- View marks in harpoon menu (`<Tab>s`)
- Delete marks with `d1`, `d2`, etc.

**Use Case:** Mark the method definition at line 56 and the call site at line 340 for quick navigation while debugging.

---

## LSP Operations

Leverage Language Server Protocol for powerful code intelligence in Java projects.

### Go to Definition

**Keybinding:** `gd`

Jump to where a variable, method, class, or interface is defined.

```lua
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]o to [D]efinition' })
```

**Use Case:** Click on `accountRepository.findById()` and jump to the repository interface definition.

### Go to Implementation

**Keybinding:** `gi`

Jump to the implementation of an interface method. If multiple implementations exist, shows a list to choose from.

```lua
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[G]o to [I]mplementation' })
```

**Use Case:** From `UserService` interface, jump to `UserServiceImpl` implementation.

### Go to Declaration

**Keybinding:** `gD`

Jump to the declaration of a symbol (useful for external dependencies).

```lua
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]o to [D]eclaration' })
```

### Find References

**Keybinding:** `gr`

Show all locations where a method, variable, or class is used across the project.

```lua
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[G]o to [R]eferences' })
```

**Use Case:** Find all controllers that call `userService.createUser()` before refactoring.

### Hover Documentation

**Keybinding:** `Shift+K`

Display method signature, parameter types, return types, and JavaDoc in a floating window.

```lua
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
```

**Use Case:** Hover over a Spring annotation to see its properties and usage.

### Rename Symbol

**Keybinding:** `<leader>rn`

Rename a variable, method, or class across the entire project. LSP ensures all references are updated.

```lua
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
```

**Requirements:** 
- Project must compile without errors
- LSP must have indexed the entire project

**Use Case:** Rename `account` to `userAccount` across all service methods and tests.

### Code Actions

**Keybinding:** `<leader>ca`

Show available code actions at cursor position (organize imports, generate getters/setters, etc.).

```lua
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
```

**Common Actions in Java:**
- Organize imports
- Generate constructor
- Generate getters/setters
- Implement interface methods
- Add missing exception handling

### List All Methods/Functions

**Keybinding:** `fm`

Display all methods, classes, and interfaces in the current file for quick navigation.

```lua
require('telescope.builtin').lsp_document_symbols()
```

**Use Case:** Open a 500-line service class and quickly jump to `updateUserProfile()` method without scrolling.

**Note:** This works for exploring third-party library code or packages you've imported.

---

## Code Manipulation

### Project-Wide Find and Replace

When LSP rename isn't available (e.g., due to compilation errors), use grep + quickfix list for manual find/replace.

**Steps:**

1. **Search for the term:**
   ```
   <leader>fg
   Balance
   ```

2. **Send results to quickfix list:**
   ```
   Ctrl+Q
   ```

3. **Replace in quickfix:**
   ```
   :cdo s/Balance/Amount/gc
   ```
   - `c` flag prompts for confirmation on each replacement
   - `y` to confirm, `n` to skip, `a` for all remaining

4. **Save all changed files:**
   ```
   :wa
   ```

**Use Case:** Replace "Balance" with "Amount" across 15 files, but skip occurrences in test mocks.

**Tip:** Use `:cdo s/Balance/Amount/gI` with `I` flag for case-insensitive replacement.

### Move Lines with Auto-Indent

**Keybindings (Visual mode):**
- `Shift+J` - Move selection down (auto-indents)
- `Shift+K` - Move selection up (auto-indents)

Select lines in visual mode and move them while maintaining proper indentation context.

```lua
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
```

**Use Case:** Move a validation block into an if-statement, and indentation adjusts automatically.

### Surround Operations

Quickly add, change, or delete surrounding characters (quotes, brackets, tags).

**Common Operations:**
- `ys{motion}{char}` - Add surround
- `cs{old}{new}` - Change surround
- `ds{char}` - Delete surround
- `S{char}` in visual mode - Surround selection

**Examples:**
```
ysiw"        - Surround inner word with "
cs"'         - Change " to '
ds"          - Delete surrounding "
v2jS(        - Select 3 lines and surround with ()
```

**Use Case:** Convert CSV headers to quoted strings or wrap JSON keys in quotes.

### Comment Toggling

**Keybindings:**
- `gcc` - Toggle comment on current line
- `gc{motion}` - Comment motion (e.g., `gc2j` comments current + 2 lines below)
- `gc3k` - Comment current line and 3 lines above
- `gb{motion}` - Block comment (for multi-line comments)
- `gc` in visual mode - Comment selection

**Plugin:** [Comment.nvim](https://github.com/numToStr/Comment.nvim)

**Use Case:** Comment out debug statements with `gc2j` or toggle single line with `gcc`.

---

## Terminal Integration

### Floating Terminal Toggle

Open a floating terminal window within Neovim for quick commands without leaving your editor.

**Keybinding:** `<leader>t` (or custom)

**Features:**
- Persistent across toggles (processes keep running)
- Run background jobs (e.g., Docker containers)
- Execute git commands quickly
- Per-buffer state maintained

**Setup Example:**
```lua
vim.keymap.set('n', '<leader>t', function()
  vim.cmd('split | terminal')
  vim.cmd('resize 15')
end, { desc = '[T]erminal' })
```

**Use Case:** Quickly `git commit` without opening a tmux pane, then close the terminal with `Ctrl+D` or toggle it away.

**Note:** Inspired by TJ DeVries' configuration.

---

## Help System

### Floating Help Window

Display Vim help in a centered floating window instead of a split, making documentation easier to read.

**Keybinding:** `:help {topic}` (automatically uses floating window if configured)

**Setup:**
```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function()
    vim.cmd('wincmd L')  -- Move help to right side
    -- Or create custom floating window
  end,
})
```

**Use Case:** Look up `:help usp` without disrupting your code layout.

---

## Quick Reference Cheatsheet

| Category | Action | Keybinding |
|----------|--------|------------|
| **Diagnostics** | Show full error | `<leader>e` |
| | Copy error | `<leader>ce` |
| | Next error | `]e` |
| | Previous error | `[e` |
| **Files** | Find files | `<leader>ff` |
| | Find hidden files | `<leader>pf` |
| | Grep in project | `<leader>fg` |
| | Recent buffers | `<leader>fb` |
| | Toggle to previous | `Ctrl+^` |
| **Harpoon** | Show marks | `<Tab>s` |
| | Add mark | `<Tab>a` |
| | Next mark | `<Tab>]` |
| | Previous mark | `<Tab>[` |
| **LSP** | Go to definition | `gd` |
| | Go to implementation | `gi` |
| | Find references | `gr` |
| | Hover docs | `Shift+K` |
| | Rename | `<leader>rn` |
| | Code actions | `<leader>ca` |
| | List symbols | `fm` |
| **Edit** | Move line down | `Shift+J` (visual) |
| | Move line up | `Shift+K` (visual) |
| | Comment toggle | `gcc` |
| | Comment motion | `gc{motion}` |
| **Terminal** | Toggle terminal | `<leader>t` |

---

## Related Documentation

- [KEYMAPS.md](./KEYMAPS.md) - Complete keybinding reference
- [JAVA_SETUP.md](./JAVA_SETUP.md) - Java/Spring Boot specific setup
- [CUSTOM_FUNCTIONS.md](./CUSTOM_FUNCTIONS.md) - Custom Lua function implementations

---

## Tips for Java Developers

1. **Use `gr` extensively** when refactoring to ensure you catch all usages
2. **Mark your test file** with Harpoon when implementing a feature (TDD workflow)
3. **Use `<leader>ca`** to organize imports frequently to keep code clean
4. **Leverage `fm`** when exploring Spring Boot autoconfiguration classes
5. **Keep terminal toggle handy** for quick Maven/Gradle commands

---

*This guide prioritizes practical, workflow-oriented techniques following the KISS principle: Keep It Simple and Stupid.*

