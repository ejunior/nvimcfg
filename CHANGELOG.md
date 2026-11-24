# Neovim 0.12+ Configuration Changelog

**Date:** 2026-11-23  
**Target Neovim Version:** `0.12.6+`

---

## Fixed Bugs

### Tree-sitter (`nvim-treesitter` `main` branch)
- **File:** `lua/plugins/treesitter.lua`
- Replaced the removed `master`-branch `opts` (`ensure_installed`, `highlight = { enable = true }`), which were silently ignored on the `main` branch.
- Loaded `nvim-treesitter` eagerly (`lazy = false`, `branch = "main"`), installed missing parsers asynchronously on `LazyDone` (`lua`, `c`, `cpp`, `cmake`, `markdown`, `markdown_inline`, `vim`, `vimdoc`), and enabled highlighting + indentation via a `FileType` autocmd using Neovim's built-in `vim.treesitter.start()` and `nvim-treesitter.indentexpr()`.

### Theme, Icons & Statusline (`lualine.nvim`, `mini.icons` & `tokyonight.nvim`)
- **Files:** `lua/plugins/colors.lua`, `lua/plugins/which-key.lua`
- Fixed typo `'tokyoknight'` → `'tokyonight'` and corrected option nesting from `opts = { theme = ... }` to `opts = { options = { theme = "tokyonight" } }`.
- Added `lazy = false` and `priority = 1000` to `folke/tokyonight.nvim` so the colorscheme loads before UI plugins.
- Replaced `nvim-tree/nvim-web-devicons` with `nvim-mini/mini.icons` (with `mock_nvim_web_devicons()`), fixing the `:checkhealth which-key` warning while providing unified icons for `which-key.nvim`, `lualine.nvim`, and `telescope.nvim`.

### Native LSP Discovery & `clangd` Command Preservation
- **Moved:** `lua/lsp/clangd.lua` → `after/lsp/clangd.lua`
- **Moved:** `lua/lsp/lua_ls.lua` → `after/lsp/lua_ls.lua`
- **Removed:** empty `lua/lsp/` directory
- Placed LSP overrides in Neovim 0.11+/0.12's native `after/lsp/<server>.lua` runtime path instead of `lua/lsp/`, fixing `lua_ls.lua` previously being ignored.
- Removed `on_attach` from `after/lsp/clangd.lua` so it no longer overwrites `nvim-lspconfig`'s built-in `on_attach` (which registers `:LspClangdSwitchSourceHeader`). Moved the `<leader>ch` mapping into the global `LspAttach` autocmd in `lua/config/lsp.lua`.
- Explicitly set `filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }` in `after/lsp/clangd.lua` to override `nvim-lspconfig`'s compound filetypes (`c.doxygen`, `cpp.doxygen`) that trigger `:checkhealth vim.lsp` warnings on Neovim 0.12.
- Moved LSP activation out of `nvim-lspconfig`'s lazy `BufReadPre` config into `lua/config/lsp.lua` (loaded right after `config.lazy`), while loading `nvim-lspconfig` eagerly (`lazy = false`) so presets are on `runtimepath` before `vim.lsp.enable()`.

### Keymap Conflicts & Deprecations
- **Files:** `lua/config/lsp.lua`, `lua/plugins/cpp-cmake.lua`
- Resolved **`<leader>cd` conflict**: kept `<leader>cd` for `CMakeDebug` and moved `vim.diagnostic.open_float` to **`<leader>d`**.
- Resolved **`gr` conflict**: removed custom `gr` mapping so Neovim 0.12's built-in `gr*` LSP keymaps work without collision (`grr` references, `grn` rename, `gra` code action, `gri` implementation, `grt` type definition, `grx` codelens).
- Removed deprecated `vim.diagnostic.goto_prev` / `vim.diagnostic.goto_next` and redundant `[d`, `]d`, and `K` overrides (all built into Neovim 0.12).
- Fixed async race in `<leader>cB` (`cmake-tools.nvim`): replaced `<cmd>CMakeClean<cr><cmd>CMakeBuild<cr>` with `<cmd>CMakeBuild!<cr>` (which runs CMake's `--clean-first` cleanly).

---

## Added Features & Neovim 0.12+ Upgrades

### Completion (`saghen/blink.cmp`)
- **Added:** `lua/plugins/completion.lua`
- Added `saghen/blink.cmp` (`version = "1.*"`) with `rafamadriz/friendly-snippets`, auto-showing docs, inline ghost text, automatic function signature help, and `lazydev` integration.
- Wired `blink.cmp` LSP capabilities globally via `vim.lsp.config("*", ...)` in `lua/config/lsp.lua`.

### Dedicated LSP & Neovim Lua Tooling
- **Added:** `lua/config/lsp.lua`, `lua/plugins/lsp.lua`
- Enabled inline diagnostics (`vim.diagnostic.config({ virtual_text = true, severity_sort = true, float = { border = "rounded", source = "if_many" } })`), which default to off in Neovim 0.11+/0.12.
- Enabled **Inlay Hints** automatically when supported (`<leader>th` to toggle) and **CodeLens** (`vim.lsp.codelens.enable`).
- Guarded server activation with `vim.fn.executable(...)` so missing servers don't emit spawn errors on file open.
- Added `folke/lazydev.nvim` for full Neovim Lua API completion and type checking with `lua_ls` and `blink.cmp`.

### Startup Safety, Core Options & Plugin Improvements
- **File:** `init.lua` — Wrapped experimental `require("vim._core.ui2").enable({})` in `pcall` and added `require("config.lsp")`.
- **File:** `lua/config/options.lua` — Added `undofile = true`, `ignorecase = true`, `smartcase = true`, `scrolloff = 8`, `clipboard = "unnamedplus"`, removed stale LSP comment, and standardized `opt.cursorline`.
- **File:** `lua/plugins/which-key.lua` — Split `which-key.nvim` out of `telescope.lua` and added group labels for `<leader>c`, `<leader>f`, `<leader>r`, and `<leader>t`.
- **File:** `lua/plugins/telescope.lua` — Added `telescope-fzf-native.nvim` (built with `make`), plus `<leader>fh` (help tags) and `<leader>fd` (diagnostics).
- **File:** `lua/plugins/oneliners.lua` — Lazy-loaded `vim-fugitive` on Git commands and `nvim-highlight-colors` on buffer read (`opts = {}`).

---

## Removed Files & Redundant Plugins

- **Removed plugin:** `ojroques/vim-oscyank` from `lua/plugins/oneliners.lua` (replaced by Neovim's built-in OSC 52 clipboard support + `clipboard = "unnamedplus"`).
- **Removed file:** `lua/config/keybinds.lua` (unused legacy file with conflicting `<leader>cd`).
- **Removed file:** `lua/plugins/harpoon._lua` (disabled file with broken top-level `telescope` requires, missing `harpoon:setup()`, typo `promt_title`, and `<C-p>`/`<C-n>` overrides).
- **Cleaned up:** Duplicate commented-out bootstrap block in `lua/config/lazy.lua` and commented `keybinds` require in `init.lua`.

---

## Keymap Summary (Changed / New)

| Keymap | Action | Scope |
|---|---|---|
| `<leader>d` | Show diagnostic float (moved from `<leader>cd`) | LSP buffer |
| `<leader>cd` | `CMakeDebug` (no longer shadowed by LSP) | C/C++/CMake |
| `<leader>cB` | `CMakeBuild!` (`--clean-first`, fixes async race) | C/C++/CMake |
| `<leader>ch` | `LspClangdSwitchSourceHeader` (via `LspAttach`) | `clangd` buffer |
| `<leader>th` | Toggle LSP Inlay Hints | LSP buffer |
| `<leader>fh` | Telescope help tags | Global |
| `<leader>fd` | Telescope diagnostics | Global |
| `grr` / `grn` / `gra` / `gri` / `grt` / `grx` | Neovim 0.12 built-in LSP actions (no longer shadowed by `gr`) | LSP buffer |

---

## Post-Update Notes

1. **Sync plugins:** Open Neovim and run `:Lazy sync` to install `blink.cmp`, `friendly-snippets`, `lazydev.nvim`, `telescope-fzf-native.nvim`, and remove `vim-oscyank`.
2. **Optional system tools:**
   - Install `lua-language-server` if you want Lua LSP diagnostics/completion (it will auto-enable once in `$PATH`).
   - Ensure `tree-sitter` CLI (`tree-sitter-cli`) is installed if `nvim-treesitter` (`main` branch) needs to compile parsers locally.
   - Install `nvim-dap` + a debug adapter (e.g., `codelldb`) if you plan to use `<leader>cd` (`CMakeDebug`).
