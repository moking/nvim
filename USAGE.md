# Neovim Usage Guide & Hotkey Cheat Sheet

This guide is generated from the current config: `init.lua`, `lua/mappings.lua`, `lua/plugins.lua`, and `lua/config/*.lua`.
It is written for C and Linux kernel work: LSP via clangd, git review, and patch workflows.

- **Leader key:** `<Space>` (written as `<leader>` below)
- **Plugin manager:** [lazy.nvim](https://github.com/folke/lazy.nvim). Use `:Lazy` to install, update, or clean plugins.
- **LSP servers:** managed with `:Mason`. `clangd` and `lua_ls` are installed automatically, and `harper_ls` (a grammar checker) is also set up.
- **Discover keys:** press `<leader>` and wait for the which-key popup, or run `<leader>sk` (Telescope keymaps).

Modes: `n` = normal, `i` = insert, `v` = visual, `x` = visual/block, `t` = terminal.

---

## 1. Typical Workflows

### 1.1 Open a kernel / C project

```bash
cd ~/src/linux
make -j$(nproc)                                  # build first
./scripts/clang-tools/gen_compile_commands.py    # generates compile_commands.json for clangd
nvim .
```

1. Press `tt` to toggle the file tree, or `ff` to fuzzy-find a file.
2. Use `<F1>` to reopen recently used files.
3. To save a project as a workspace, run `:WorkspacesAdd`. Later, use `fw` to jump between workspaces.

### 1.2 Navigate code (LSP + Telescope)

| Goal                                   | Key                    |
| -------------------------------------- | ---------------------- |
| Go to definition                       | `<C-]>` or `fd`        |
| Jump back                              | `fb` or `<C-t>`        |
| Find references (Telescope)            | `fr` or `<C-\>r`       |
| Grep word under cursor (git root)      | `fs` or `<C-\>s`       |
| Live grep (git root)                   | `ft` or `<C-\>t`       |
| Workspace symbol search                | `fg`                   |
| Hover docs                             | `K`                    |
| Signature help                         | `<C-k>`                |
| Who calls this function (call tree)    | `<leader>cf`           |
| What this function calls (call tree)   | `<leader>ct`           |
| Symbol outline sidebar                 | `ts`                   |
| Line diagnostics popup (toggle)        | `<C-e>`                |

The Telescope pickers behind `fr`, `fs`, `ft`, and `fg` push to the tag stack, so `fb` (`<C-t>`) returns you to where you started.
In these pickers, `<C-g>` switches to fuzzy-refine mode, which narrows the current results with a fuzzy search.

### 1.3 Review a patch / git history

1. `<leader>gl`: show the commit (`git show`) that last touched the current line, in a floating terminal.
2. Select lines in visual mode, then:
   - `x`: run `Git log -L` for those lines (fugitive, shown full-window). **Note:** this replaces visual-mode delete with `x`, so use `d` instead.
   - `fh`: open a Telescope picker of commits that touched the selected range.
3. From a fugitive commit/file buffer, `<C-\>w` checks that commit out into a git worktree at `~/.COMMIT-WORKSPACE/commit-<repo>` and opens the same file there.
4. `<F5>`: send all git-gutter hunks to the quickfix list.
5. Add review tags below the cursor line:
   - `rb`: insert `Reviewed-by: Fan Ni <fan.ni@samsung.com>`
   - `tb`: insert `Tested-by: Fan Ni <fan.ni@samsung.com>`
6. Full git UI: `:Neogit` (Magit-style, opens in a tab) or `:Git` (fugitive).
7. Patch-style git log browser: `:Glance log [git-log-args]`, for example `:Glance log -100`.
8. Gitee PR browser (repo `openeuler/kernel`; token in `~/.token.gitee`): `:Gitee prlist`, `:Gitee pr <num>`.

### 1.4 Editing helpers

- `gcc` / `gc{motion}`: toggle line comment (Comment.nvim). `gbc` toggles a block comment. In visual mode, use `gc` / `gb`.
- `ga{motion}{char}`: align text on a character (mini.align). Example: `gaip=` aligns a paragraph on `=`.
- `--`: turn the current line into a markdown bullet (`\t- ...`).
- Visual `J` / `K`: move the selected lines down/up.
- Visual `<` / `>`: indent and keep the selection.
- Visual `p`: paste over the selection without overwriting the register.
- Insert `<C-l>`: jump past the next closing `)`, `]`, `}`, `>`, quote, or `,`.
- Insert `<C-f>`: fix the previous spelling error with the first suggestion.
- `<leader>y`: yank the word under cursor (`yiw`).
- `<leader>d`: look up the word under cursor in a dictionary (dict.nvim).
- `<F3>`: toggle display of whitespace characters (`list`). `<F4>`: toggle `expandtab`.

### 1.5 Terminals and tools

- `<C-n>`: toggle a floating terminal (ToggleTerm). To hide it, first leave terminal mode with `<C-\><C-n>`, then press `<C-n>`.
- `<M-x>`: start typing a `:FloatermNew ...` command. Add your shell command and press Enter.
- `<leader>xb`: open the `w3m` text browser in a floating terminal.
- `<leader>xr`: run the REST request under the cursor (vim-rest-console). Output goes to `_OUTPUT.json`, formatted with `jq`.

### 1.6 Notes / wiki

Vimwiki stores notes in `~/vimwiki/src/` as markdown files.

Vimwiki's key prefix is set to `<leader>v`, which keeps `<leader>w` free for window picking.

Markdown files (and Vimwiki notes) are rendered in the buffer by render-markdown.nvim: styled headings, drawn tables, code block backgrounds, and icons for bullets and checkboxes. The line under the cursor shows raw text for editing. Use `:RenderMarkdown toggle` to switch between rendered and raw text.

- `<leader>vw`: open the wiki index. `<leader>vt`: open it in a new tab.
- `<leader>vi`: open the diary index. `<leader>v<leader>w`: open today's diary note.

---

## 2. Hotkey Reference

### 2.1 Basics, files & buffers (normal mode)

| Key                 | Action                                                        |
| ------------------- | ------------------------------------------------------------- |
| `<F1>`              | Telescope: recent files                                       |
| `<F2>`              | Save buffer (also works in insert mode)                       |
| `qq`                | Quit window (`:q`)                                            |
| `ww`                | Cycle to the next window                                      |
| `<leader>w`         | Pick a window by number (nvim-window)                         |
| `<C-x>2` / `<C-x>3` | Horizontal / vertical split                                   |
| `<C-Left>` / `<C-Right>` | Previous / next tab                                      |
| `<Tab>` / `<S-Tab>` | Next / previous Harpoon file (falls back to next/prev buffer) |
| `tt`                | Toggle file tree (nvim-tree)                                  |
| `<leader>fT`        | Reveal current file in the tree                               |
| `ff`                | Telescope: find files                                         |
| `<leader>ff`        | Telescope: find files with `fd` (includes hidden files, follows symlinks) |
| `<leader>fr`        | Telescope: recent files                                       |
| `<leader>bb`        | Telescope: switch buffer (most recently used first)           |
| `<leader>bd`        | Close current buffer                                          |
| `<leader>ba`        | Close all buffers except the current one                      |
| `<leader>bn` / `<leader>bp` | Next / previous buffer                                |
| `fw`                | Telescope: switch workspace                                   |
| `fc`                | Pick a colorscheme with live preview                          |
| `tv`                | Start visual-block mode (alternative to `<C-v>` for terminals that capture it) |
| `<C-h>`             | Open `:help` for the word under cursor                        |
| `<Esc>`             | Clear search highlight                                        |
| `n` / `N`           | Next / previous match, centered on screen                     |
| `*` / `#` / `g*` / `g#` | Search word without moving the cursor (starlite)          |
| `j` / `k`           | Move by visual (wrapped) lines when no count is given         |

### 2.2 Harpoon (quick file marks)

| Key        | Action                                       |
| ---------- | -------------------------------------------- |
| `m`        | Add current file to Harpoon (replaces Vim marks) |
| `MM`       | Toggle Harpoon quick menu (edit/reorder list) |
| `<leader>fh` | Pick a Harpoon file in Telescope (with preview) |
| `M1`..`M5` | Jump to Harpoon file 1–5                     |
| `<Tab>` / `<S-Tab>` | Cycle through Harpoon files          |

### 2.3 LSP (`<leader>l` group)

| Key           | Action                         |
| ------------- | ------------------------------ |
| `<leader>ld`  | Go to definition               |
| `<leader>lD`  | Go to declaration              |
| `<leader>lI`  | Implementations                |
| `<leader>lt`  | Type definition                |
| `<leader>lr`  | References (Telescope)         |
| `<leader>ls`  | Document symbols               |
| `<leader>lS`  | Workspace symbols              |
| `<leader>lR`  | Rename symbol                  |
| `<leader>la`  | Code action                    |
| `<leader>lf`  | Format buffer                  |
| `<leader>lq`  | Diagnostics to location list   |
| `<leader>lK`  | Hover                          |
| `<leader>lk`  | Signature help                 |
| `<leader>ll`  | Line diagnostics float         |
| `<leader>ln` / `<leader>lp` | Next / previous diagnostic |
| `<leader>le`  | Buffer diagnostics (Telescope) |
| `<leader>lw`  | Workspace diagnostics          |
| `<leader>li`  | `:LspInfo`                     |
| `<leader>lA` / `<leader>lW` / `<leader>lL` | Add / remove / list workspace folders |

Diagnostics show only as signs in the sign column. Inline virtual text is disabled, so use `<C-e>` or `<leader>ll` to read a diagnostic.

lspsaga loads when an LSP server attaches. It has no keys mapped, but its commands are available, for example `:Lspsaga finder`, `:Lspsaga peek_definition`, `:Lspsaga incoming_calls`, and `:Lspsaga rename`.

### 2.4 Search (`<leader>s` group)

| Key           | Action                          |
| ------------- | ------------------------------- |
| `<leader>st`  | Live grep                       |
| `<leader>ss`  | Grep word under cursor          |
| `<leader>sh`  | Help tags                       |
| `<leader>sM`  | Man pages                       |
| `<leader>sk`  | Keymaps                         |
| `<leader>sc`  | Commands                        |
| `<leader>sR`  | Registers                       |
| `<leader>sC` / `<leader>sP` | Colorschemes (with preview for `sP`) |

### 2.5 Git (`<leader>g` group + others)

| Key           | Action                                             |
| ------------- | -------------------------------------------------- |
| `<leader>gg`  | Telescope: changed files (git status)              |
| `<leader>gb`  | Telescope: checkout branch                         |
| `<leader>gc`  | Telescope: browse commits                          |
| `<leader>gC`  | Telescope: commits for current file                |
| `<leader>gl`  | `git show` the commit that last touched this line  |
| `<leader>gB`  | Toggle inline blame for the current line (gitsigns) |
| `x` (visual)  | `Git log -L` for selected lines                    |
| `fh` (visual) | Telescope: commits touching selected range         |
| `<C-\>w`      | Check out fugitive commit into a worktree workspace |
| `<F5>`        | GitGutter hunks into quickfix                      |
| `rb` / `tb`   | Insert Reviewed-by / Tested-by tag                 |
| `[c` / `]c`   | Previous / next hunk (gitgutter)                   |

Useful commands: `:Gitsigns toggle_current_line_blame`, `:Gitsigns preview_hunk`, `:Git blame`, `:Gdiffsplit`, `:DiffviewOpen`.

### 2.6 Spelling (`<leader>z` group)

| Key           | Action                      |
| ------------- | --------------------------- |
| `<leader>zn` / `<leader>zp` | Next / previous misspelling |
| `<leader>zf`  | Apply first suggestion      |
| `<leader>zl`  | List suggestions (Telescope) |
| `<leader>za`  | Add word to dictionary      |

### 2.7 Completion (insert mode, nvim-cmp)

| Key                 | Action                                     |
| ------------------- | ------------------------------------------ |
| `<C-Space>`         | Trigger completion                         |
| `<Tab>` / `<S-Tab>` | Next / previous item, or jump through snippet placeholders |
| `<C-j>` / `<C-k>`   | Next / previous item                       |
| `<CR>`              | Confirm (selects first item if none chosen) |
| `<C-e>`             | Abort completion                           |
| `<C-b>` / `<C-f>`   | Scroll docs window                         |

Completion sources: LSP, LuaSnip snippets, buffer words, and file paths.

### 2.8 Treesitter selection & text objects

| Key                 | Action                                              |
| ------------------- | --------------------------------------------------- |
| `<CR>` (normal)     | Start incremental selection at the cursor's syntax node |
| `<CR>` (visual)     | Expand to enclosing scope                           |
| `<Tab>` / `<S-Tab>` (visual) | Grow / shrink selection by node            |
| `af` / `if`         | Function (outer / inner)                            |
| `ac` / `ic`         | Class (outer / inner)                               |
| `al` / `il`         | Loop (outer / inner)                                |
| `ab` / `ib`         | Block (outer / inner)                               |
| `ar` / `ir`         | Parameter (outer / inner)                           |

Example: `daf` deletes a function, `vir` selects an argument, and `yib` yanks a block body.

### 2.9 Telescope picker keys (inside any picker)

| Key                     | Action                                    |
| ----------------------- | ----------------------------------------- |
| `<Esc>`                 | Close                                     |
| `<Up>` / `<Down>`       | Move selection                            |
| `<PageUp>` / `<PageDown>` | Scroll results by a page                |
| `<C-Up>` / `<C-Down>`   | Scroll preview                            |
| `<C-PageUp>` / `<C-PageDown>` | Scroll preview by a page            |
| `<Tab>`                 | Toggle multi-select and move down         |
| `<C-s>`                 | Send selected entries to quickfix (replace) |
| `<C-a>`                 | Add selected entries to quickfix          |
| `<C-e>`                 | Open entry and keep picker (resume)       |
| `<C-g>`                 | Fuzzy-refine results (grep/refs/symbol pickers) |

### 2.10 File tree (nvim-tree, inside the tree window)

| Key                  | Action                           |
| -------------------- | -------------------------------- |
| `<CR>` / `o`         | Open                             |
| `<C-v>` / `<C-x>` / `<C-t>` | Open in vsplit / split / tab |
| `<Tab>`              | Preview                          |
| `<C-]>` / `-`        | Make dir the root / go up a level |
| `P` / `<BS>`         | Go to parent / close parent dir  |
| `a` / `d` / `r`      | Create / delete / rename         |
| `x` / `c` / `p`      | Cut / copy / paste               |
| `y` / `Y` / `gy`     | Copy name / relative path / absolute path |
| `H`                  | Toggle dotfiles                  |
| `R`                  | Refresh                          |
| `[c` / `]c`          | Previous / next git-changed file |
| `q`                  | Close tree                       |
| `g?`                 | Help                             |

Hidden by default: dotfiles, `.o`, `.ko`, `.a`, `.mod`, `.git*`, `modules.order`.

### 2.11 Neogit (`:Neogit`)

The status buffer opens in a new tab.

| Key            | Action                                            |
| -------------- | ------------------------------------------------- |
| `<Tab>`        | Expand/collapse item                              |
| `s` / `S` / `<C-s>` | Stage item / stage all unstaged / stage everything |
| `u` / `U`      | Unstage item / unstage all                        |
| `x`            | Discard                                           |
| `c`            | Commit popup                                      |
| `P` / `p` / `f`| Push / pull / fetch popups                        |
| `b` / `r` / `m`| Branch / rebase / merge popups                    |
| `l`            | Log popup                                         |
| `Z`            | Stash popup                                       |
| `A` / `v`      | Cherry-pick / revert popup                        |
| `<CR>`         | Go to file                                        |
| `?`            | Help                                              |
| `q`            | Close                                             |

In the commit editor, `<C-c><C-c>` submits and `<C-c><C-k>` aborts.

### 2.12 Symbol outline (`ts`, inside the outline window)

`<CR>` goes to the symbol, `o` focuses it, `K` toggles preview, `r` renames, `a` runs a code action, `h`/`l` fold/unfold, `W`/`E` fold/unfold all, and `q` or `<Esc>` closes.

### 2.13 Other plugin defaults

- **vim-unimpaired:** `[b`/`]b` buffers, `[q`/`]q` quickfix, `[l`/`]l` location list, `[<Space>`/`]<Space>` add blank line, `[e`/`]e` swap lines.
- **Quick close:** `q` closes help, quickfix, man, fugitive, git, lspinfo, and notify windows.
- **Help:** help windows always open in a vertical split on the right.

---

## 3. Behavior worth knowing

- The system clipboard is shared (`clipboard=unnamedplus`), and the mouse is enabled.
- A column marker is shown at 80 characters, and `textwidth=80`. Indentation is auto-detected per file by vim-sleuth.
- Neovim reopens each file at the last cursor position.
- Yanked text is briefly highlighted.
- Files named `*patch.diff` get bold add/delete line highlighting.
- The `:` and `/` command lines have fuzzy completion popups (wilder.nvim).
- The default colorscheme is `carbonized-dark`. Use `fc` to switch for the session.

### Keys that shadow Vim defaults

| Key      | Vim default it replaces        |
| -------- | ------------------------------ |
| `m`      | Set mark (now Harpoon add)     |
| `x` (visual) | Delete selection (now git log for lines; use `d`) |
| `<CR>` (normal) | Move down a line (now Treesitter selection, in buffers with a parser) |
| `<Tab>`  | Jump forward in jumplist, same as `<C-i>` (now Harpoon next) |
| `fb`, `fc`, `fd`, `ff`, `fg`, `fr`, `fs`, `ft`, `fw` | `f{char}` find for those letters waits for the mapping timeout |
| `rb`, `tb`, `tt`, `ts`, `tv` | `r{char}` / `t{char}` for those letters |
| `qq`     | Record macro into register `q` |
| `ww`     | Word motion twice              |
