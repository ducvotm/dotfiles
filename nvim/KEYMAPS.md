# Neovim Keymaps Reference

Complete keybinding reference organized by category. All keybindings assume default `<leader>` is space.

## Quick Lookup Table

### Diagnostics & Errors

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<leader>e` | Normal | Show diagnostic | Open floating window with full error message |
| `<leader>ce` | Normal | Copy error | Copy diagnostic message to clipboard |
| `]e` | Normal | Next diagnostic | Jump to next error/warning |
| `[e` | Normal | Previous diagnostic | Jump to previous error/warning |
| `]d` | Normal | Next diagnostic (alt) | Alternative binding for next diagnostic |
| `[d` | Normal | Previous diagnostic (alt) | Alternative binding for previous diagnostic |

### File Navigation - Telescope

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<leader>ff` | Normal | Find files | Search files in project (respects .gitignore) |
| `<leader>pf` | Normal | Project files | Find all files including hidden (.env, .gitignore) |
| `<leader>fg` | Normal | Find grep | Live grep search across all files |
| `<leader>fb` | Normal | Find buffers | List recently opened files with buffer numbers |
| `<leader>fh` | Normal | Find help | Search Vim help tags |
| `<leader>fw` | Normal | Find word | Search for word under cursor in project |
| `<leader>fr` | Normal | Find resume | Resume previous telescope search |
| `<C-q>` | Insert (Telescope) | To quickfix | Send telescope results to quickfix list |

### File Navigation - General

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<C-^>` | Normal | Alternate file | Toggle between current and previous file |
| `<C-o>` | Normal | Jump back | Go to previous location in jump list |
| `<C-i>` | Normal | Jump forward | Go to next location in jump list |
| `:Ex` | Command | Explorer | Open netrw file explorer |

### Buffer Management

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<leader>bd` | Normal | Buffer delete | Close current buffer |
| `<leader>bn` | Normal | Buffer next | Go to next buffer |
| `<leader>bp` | Normal | Buffer previous | Go to previous buffer |
| `:ls` | Command | List buffers | Show all open buffers |
| `:b <num>` | Command | Go to buffer | Jump to buffer by number |
| `:b <name>` | Command | Go to buffer | Jump to buffer by name (supports tab-completion) |

### Harpoon - File Marking

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<Tab>s` | Normal | Show marks | Toggle harpoon menu to view marked files |
| `<Tab>a` | Normal | Add mark | Add current file to harpoon marks |
| `<Tab>[` | Normal | Previous mark | Navigate to previous marked file |
| `<Tab>]` | Normal | Next mark | Navigate to next marked file |
| `m` | Normal | Mark line | Mark current line within file |
| `d1`, `d2`... | Harpoon menu | Delete mark | Delete specific mark by number |
| `1-9` | Harpoon menu | Jump to mark | Jump to marked file by number |

### LSP - Navigation

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `gd` | Normal | Go to definition | Jump to where symbol is defined |
| `gD` | Normal | Go to declaration | Jump to declaration (useful for headers) |
| `gi` | Normal | Go to implementation | Jump to implementation of interface |
| `gr` | Normal | Go to references | List all references to symbol |
| `gt` | Normal | Go to type definition | Jump to type definition |
| `K` | Normal | Hover | Show documentation in floating window |
| `<C-k>` | Insert | Signature help | Show function signature while typing |

### LSP - Code Actions

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<leader>rn` | Normal | Rename | Rename symbol across project |
| `<leader>ca` | Normal | Code action | Show available code actions |
| `<leader>f` | Normal | Format | Format current buffer with LSP |
| `<leader>ws` | Normal | Workspace symbols | Search symbols across workspace |
| `fm` | Normal | File methods | List all methods/functions in current file |

### Code Editing - Basic

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `J` | Normal | Join lines | Join line below with current line |
| `<Shift-J>` | Visual | Move down | Move selected lines down (auto-indent) |
| `<Shift-K>` | Visual | Move up | Move selected lines up (auto-indent) |
| `>` | Visual | Indent right | Indent selection right |
| `<` | Visual | Indent left | Indent selection left |
| `.` | Normal | Repeat | Repeat last change |
| `u` | Normal | Undo | Undo last change |
| `<C-r>` | Normal | Redo | Redo last undone change |

### Code Editing - Comments

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `gcc` | Normal | Toggle comment | Comment/uncomment current line |
| `gc{motion}` | Normal | Comment motion | Comment text object (e.g., `gc2j`, `gcip`) |
| `gc2j` | Normal | Comment down | Comment current line + 2 lines below |
| `gc3k` | Normal | Comment up | Comment current line + 3 lines above |
| `gc` | Visual | Comment selection | Comment/uncomment selected lines |
| `gb{motion}` | Normal | Block comment | Block comment style (/**/) |
| `gb` | Visual | Block comment | Block comment selection |

### Code Editing - Surround

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `ys{motion}{char}` | Normal | Add surround | Surround motion with character |
| `ysiw"` | Normal | Surround word | Surround inner word with quotes |
| `ysiw(` | Normal | Surround word | Surround word with parentheses (with spaces) |
| `ysiw)` | Normal | Surround word | Surround word with parentheses (no spaces) |
| `cs{old}{new}` | Normal | Change surround | Change surrounding character |
| `cs"'` | Normal | Change quotes | Change double quotes to single quotes |
| `ds{char}` | Normal | Delete surround | Remove surrounding character |
| `ds"` | Normal | Delete quotes | Remove surrounding quotes |
| `S{char}` | Visual | Surround selection | Surround visual selection |

### Window Management

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<C-w>s` | Normal | Split horizontal | Split window horizontally |
| `<C-w>v` | Normal | Split vertical | Split window vertically |
| `<C-w>q` | Normal | Close window | Close current window |
| `<C-w>o` | Normal | Only window | Close all other windows |
| `<C-w>h` | Normal | Window left | Move to window on left |
| `<C-w>j` | Normal | Window down | Move to window below |
| `<C-w>k` | Normal | Window up | Move to window above |
| `<C-w>l` | Normal | Window right | Move to window on right |
| `<C-w>=` | Normal | Equal size | Make all windows equal size |
| `<C-w>_` | Normal | Max height | Maximize current window height |
| `<C-w>|` | Normal | Max width | Maximize current window width |

### Terminal

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<leader>t` | Normal | Toggle terminal | Open floating terminal |
| `<C-\><C-n>` | Terminal | Normal mode | Exit terminal mode to normal mode |
| `i` or `a` | Normal (in terminal) | Terminal mode | Enter terminal insert mode |
| `<C-d>` | Terminal | Exit | Close terminal (if shell exits) |

### Search & Replace

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `/pattern` | Normal | Search forward | Search for pattern forward |
| `?pattern` | Normal | Search backward | Search for pattern backward |
| `n` | Normal | Next match | Go to next search match |
| `N` | Normal | Previous match | Go to previous search match |
| `*` | Normal | Search word | Search for word under cursor (forward) |
| `#` | Normal | Search word back | Search for word under cursor (backward) |
| `:%s/old/new/g` | Command | Replace all | Replace all occurrences in file |
| `:%s/old/new/gc` | Command | Replace confirm | Replace with confirmation |
| `:cdo s/old/new/gc` | Command | Replace quickfix | Replace in all quickfix entries |

### Quickfix & Location Lists

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `:copen` | Command | Open quickfix | Open quickfix window |
| `:cclose` | Command | Close quickfix | Close quickfix window |
| `:cnext` | Command | Next quickfix | Go to next quickfix item |
| `:cprev` | Command | Previous quickfix | Go to previous quickfix item |
| `]q` | Normal | Next quickfix | Alternative binding for next item |
| `[q` | Normal | Previous quickfix | Alternative binding for previous item |
| `:cdo {cmd}` | Command | Do in quickfix | Execute command on all quickfix items |

### Marks & Jumps

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `m{a-z}` | Normal | Set mark | Set local mark (lowercase) |
| `m{A-Z}` | Normal | Set mark | Set global mark (uppercase, across files) |
| `'{mark}` | Normal | Jump to mark line | Jump to marked line (first non-blank) |
| `` `{mark} `` | Normal | Jump to mark | Jump to exact mark position |
| `''` | Normal | Jump back | Jump back to previous position (line) |
| ``` `` ``` | Normal | Jump back exact | Jump back to exact previous position |
| `:marks` | Command | List marks | Show all marks |

### Text Objects

Common text objects for use with operators (d, c, y, v, etc.):

| Text Object | Description | Example |
|-------------|-------------|---------|
| `iw` | Inner word | `diw` - delete word |
| `aw` | A word (with space) | `daw` - delete word with space |
| `iW` | Inner WORD | `diW` - delete WORD (includes punctuation) |
| `is` | Inner sentence | `cis` - change sentence |
| `ip` | Inner paragraph | `vip` - select paragraph |
| `i"` | Inner quotes | `ci"` - change inside quotes |
| `a"` | A quotes (with quotes) | `da"` - delete with quotes |
| `i(` or `i)` or `ib` | Inner parentheses | `ci(` - change inside parens |
| `a(` or `a)` or `ab` | A parentheses | `da(` - delete with parens |
| `i{` or `i}` or `iB` | Inner braces | `ci{` - change inside braces |
| `it` | Inner tag | `dit` - delete inside HTML tag |
| `at` | A tag | `dat` - delete with HTML tag |

### Registers

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `"{reg}y` | Normal/Visual | Yank to register | Copy to specific register |
| `"{reg}p` | Normal | Paste from register | Paste from specific register |
| `"+y` | Visual | Yank to clipboard | Copy to system clipboard |
| `"+p` | Normal | Paste from clipboard | Paste from system clipboard |
| `"*y` | Visual | Yank to selection | Copy to selection clipboard (X11) |
| `:reg` | Command | Show registers | Display all register contents |
| `"0p` | Normal | Paste last yank | Paste from yank register (not delete) |

### Macros

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `q{a-z}` | Normal | Record macro | Start recording macro to register |
| `q` | Normal (recording) | Stop recording | Stop macro recording |
| `@{a-z}` | Normal | Play macro | Execute macro from register |
| `@@` | Normal | Repeat macro | Repeat last executed macro |
| `10@a` | Normal | Play macro 10x | Execute macro 10 times |

### Miscellaneous

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `<leader>w` | Normal | Save file | Write current buffer |
| `<leader>q` | Normal | Quit | Close window |
| `<leader>Q` | Normal | Quit all | Close all windows (quit Vim) |
| `<Esc>` | Insert/Visual | Normal mode | Return to normal mode |
| `<C-c>` | Insert | Normal mode | Alternative to Esc |
| `<C-[>` | Insert | Normal mode | Another alternative to Esc |
| `ZZ` | Normal | Save & quit | Write and quit |
| `ZQ` | Normal | Quit no save | Quit without saving |

### Help System

| Keybinding | Mode | Action | Description |
|------------|------|--------|-------------|
| `:help {topic}` | Command | Show help | Open help for topic |
| `:help {topic}<C-d>` | Command | Help completion | Show help topics matching pattern |
| `<C-]>` | Normal (help) | Follow link | Jump to help tag under cursor |
| `<C-o>` | Normal (help) | Go back | Return to previous help location |
| `:helpgrep {pattern}` | Command | Search help | Search all help files |

---

## Java-Specific Common Workflows

### Refactoring a Method Name

1. Place cursor on method name
2. `gr` to check all usages
3. `<leader>rn` to rename across project
4. Enter new name

### Exploring a New Codebase

1. `<leader>ff` to find main application class
2. `gd` to jump to interesting classes
3. `<Tab>a` to mark files
4. `fm` to list methods in large classes
5. `<C-o>` to jump back

### Fixing Compilation Errors

1. `]e` to jump to first error
2. `<leader>e` to see full message
3. `<leader>ca` for quick fixes
4. Continue with `]e` until done

### Implementing an Interface

1. `gi` on interface method to check existing implementations
2. `gd` to see interface definition
3. `<leader>ca` to generate implementation

---

## Configuration Notes

Default `<leader>` key is typically `Space`. To verify or change:

```lua
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
```

Many keybindings require plugins:

- **Telescope:** `<leader>ff`, `<leader>fg`, etc.
- **Harpoon:** `<Tab>` bindings
- **Comment.nvim:** `gcc`, `gc`
- **nvim-surround:** `ys`, `cs`, `ds`
- **LSP:** `gd`, `gr`, `<leader>rn`, etc.

See [JAVA_SETUP.md](./JAVA_SETUP.md) for plugin installation details.

---

*This keymap reference is designed for quick lookup. For detailed explanations and use cases, see [VIM_TIPS.md](./VIM_TIPS.md).*
