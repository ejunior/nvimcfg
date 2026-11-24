# nvimcfg

Configuração modular do **Neovim 0.12+** em Lua, gerenciada com [`lazy.nvim`](https://github.com/folke/lazy.nvim), utilizando APIs nativas de LSP (`vim.lsp.config` / `vim.lsp.enable`) e Tree-sitter, com foco em desenvolvimento **Lua** e **C/C++ (CMake)**.

- 📖 **Atalhos e opções detalhadas:** [`keymap.md`](keymap.md)
- 📝 **Histórico de alterações:** [`CHANGELOG.md`](CHANGELOG.md)
- 📄 **Licença:** [`LICENSE`](LICENSE) (GPL-3.0)

---

## Requisitos

- **Neovim** `0.12+`
- **Git**
- **Nerd Font** (recomendado para ícones do `mini.icons` e `blink.cmp`)
- **`make`** e compilador C (para compilar `telescope-fzf-native.nvim` e parsers do `nvim-treesitter`)
- **`ripgrep` (`rg`)** (para busca de texto com `Telescope live_grep`)
- **Servidores LSP opcionais no `$PATH`** (ativados automaticamente se encontrados):
  - `clangd` (C / C++)
  - `lua-language-server` (Lua)
- **`cmake`** (para `cmake-tools.nvim` em projetos C/C++)

## Instalação

```bash
git clone git@github.com:ejunior/nvimcfg.git ~/.config/nvim
nvim
```

Na primeira execução, o `lazy.nvim` será clonado automaticamente e instalará todos os plugins travados em [`lazy-lock.json`](lazy-lock.json).

---

## Plugins Configurados

### Gerenciador de Plugins

| Plugin | Descrição | Arquivo(s) |
| --- | --- | --- |
| [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim) | Gerenciador de plugins com bootstrap automático e importação de `lua/plugins/` | [`lua/config/lazy.lua`](lua/config/lazy.lua) |

### Interface, Tema e Ícones

| Plugin | Descrição | Arquivo(s) |
| --- | --- | --- |
| [`folke/tokyonight.nvim`](https://github.com/folke/tokyonight.nvim) | Esquema de cores principal (`tokyonight`, carregado com prioridade máxima) | [`lua/plugins/colors.lua`](lua/plugins/colors.lua) |
| [`nvim-mini/mini.icons`](https://github.com/nvim-mini/mini.icons) | Biblioteca de ícones com emulação de `nvim-web-devicons` para `lualine`, `telescope`, `snacks` e `which-key` | [`lua/plugins/colors.lua`](lua/plugins/colors.lua) |
| [`nvim-lualine/lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim) | Barra de status configurada com o tema `tokyonight` | [`lua/plugins/colors.lua`](lua/plugins/colors.lua) |
| [`brenoprata10/nvim-highlight-colors`](https://github.com/brenoprata10/nvim-highlight-colors) | Destaca cores CSS/hexadecimais diretamente no buffer | [`lua/plugins/oneliners.lua`](lua/plugins/oneliners.lua) |

### Navegação, Busca e Atalhos

| Plugin | Descrição | Arquivo(s) |
| --- | --- | --- |
| [`folke/snacks.nvim`](https://github.com/folke/snacks.nvim) | Explorador de arquivos lateral (`explorer`, `<leader>e`), `picker` e terminal integrado (`terminal`, `<C-/>`) | [`lua/plugins/snacks.lua`](lua/plugins/snacks.lua) |
| [`nvim-telescope/telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder para arquivos, grep, buffers, ajuda e diagnósticos (`<leader>f*`) | [`lua/plugins/telescope.lua`](lua/plugins/telescope.lua) |
| [`nvim-telescope/telescope-fzf-native.nvim`](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Extensão nativa (`fzf` compilada via `make`) para acelerar buscas do Telescope | [`lua/plugins/telescope.lua`](lua/plugins/telescope.lua) |
| [`folke/which-key.nvim`](https://github.com/folke/which-key.nvim) | Popup interativo de atalhos e definição de grupos (`<leader>c`, `f`, `g`, `r`, `t`, `gr`) | [`lua/plugins/which-key.lua`](lua/plugins/which-key.lua) |

### LSP, Autocompletar e Sintaxe

| Plugin | Descrição | Arquivo(s) |
| --- | --- | --- |
| [`neovim/nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) | Presets oficiais de servidores LSP carregados antes do `vim.lsp.enable()` | [`lua/plugins/lsp.lua`](lua/plugins/lsp.lua), [`lua/config/lsp.lua`](lua/config/lsp.lua), [`after/lsp/clangd.lua`](after/lsp/clangd.lua), [`after/lsp/lua_ls.lua`](after/lsp/lua_ls.lua) |
| [`folke/lazydev.nvim`](https://github.com/folke/lazydev.nvim) | Tipos e completação da API Lua do Neovim e plugins (`vim.uv`, `Snacks`) para `lua_ls` e `blink.cmp` | [`lua/plugins/lsp.lua`](lua/plugins/lsp.lua), [`lua/plugins/completion.lua`](lua/plugins/completion.lua) |
| [`saghen/blink.cmp`](https://github.com/saghen/blink.cmp) | Motor de autocompletar (`v1.*`) com documentação automática, *ghost text*, assinatura de funções e fonte `lazydev` | [`lua/plugins/completion.lua`](lua/plugins/completion.lua), [`lua/config/lsp.lua`](lua/config/lsp.lua) |
| [`rafamadriz/friendly-snippets`](https://github.com/rafamadriz/friendly-snippets) | Coleção de snippets pré-prontos usada pelo `blink.cmp` | [`lua/plugins/completion.lua`](lua/plugins/completion.lua) |
| [`nvim-treesitter/nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) | Branch `main` com instalação automática de parsers (`lua`, `c`, `cpp`, `cmake`, `markdown`, `markdown_inline`, `vim`, `vimdoc`), highlight e indentação nativos | [`lua/plugins/treesitter.lua`](lua/plugins/treesitter.lua) |

### Git e C/C++ (CMake)

| Plugin | Descrição | Arquivo(s) |
| --- | --- | --- |
| [`tpope/vim-fugitive`](https://github.com/tpope/vim-fugitive) | Integração Git (`:Git`, diff, blame, log, commit, push em `<leader>g*`) | [`lua/plugins/oneliners.lua`](lua/plugins/oneliners.lua) |
| [`Civitasv/cmake-tools.nvim`](https://github.com/Civitasv/cmake-tools.nvim) | Workflow CMake para C/C++ (generate, build, run, debug, clean e seletores em `<leader>c*`) | [`lua/plugins/cpp-cmake.lua`](lua/plugins/cpp-cmake.lua) |

### Dependências Compartilhadas

| Plugin | Descrição | Arquivo(s) |
| --- | --- | --- |
| [`nvim-lua/plenary.nvim`](https://github.com/nvim-lua/plenary.nvim) | Biblioteca utilitária Lua usada por `telescope.nvim` e `cmake-tools.nvim` | [`lua/plugins/telescope.lua`](lua/plugins/telescope.lua), [`lua/plugins/cpp-cmake.lua`](lua/plugins/cpp-cmake.lua) |

---

## Estrutura dos Arquivos

```text
.
├── init.lua                    # Ponto de entrada: ativa ui2, desativa providers e carrega config/*
├── lazy-lock.json              # Versões (commits) fixadas dos plugins gerenciados pelo lazy.nvim
├── keymap.md                   # Referência completa de atalhos e opções
├── CHANGELOG.md                # Histórico de correções e melhorias
├── after/
│   └── lsp/
│       ├── clangd.lua          # Sobrescrita nativa do servidor clangd (C/C++)
│       └── lua_ls.lua          # Sobrescrita nativa do servidor lua_ls (Lua)
└── lua/
    ├── config/
    │   ├── options.lua         # Opções gerais do editor (numeração, indentação, busca, clipboard, etc.)
    │   ├── keymaps.lua         # Teclas líderes (<Space>, \) e atalhos globais
    │   ├── lazy.lua            # Bootstrap e setup do lazy.nvim
    │   └── lsp.lua             # Diagnósticos, capabilities do blink.cmp, LspAttach e vim.lsp.enable()
    └── plugins/
        ├── colors.lua          # tokyonight.nvim, mini.icons, lualine.nvim
        ├── completion.lua      # blink.cmp, friendly-snippets
        ├── cpp-cmake.lua       # cmake-tools.nvim (+ plenary.nvim)
        ├── lsp.lua             # nvim-lspconfig, lazydev.nvim
        ├── oneliners.lua       # vim-fugitive, nvim-highlight-colors
        ├── snacks.lua          # snacks.nvim (+ mini.icons)
        ├── telescope.lua       # telescope.nvim, telescope-fzf-native.nvim (+ plenary.nvim)
        ├── treesitter.lua      # nvim-treesitter (branch main)
        └── which-key.lua       # which-key.nvim (+ mini.icons)
```
