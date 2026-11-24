# Referência da Configuração do Neovim

Documentação completa dos atalhos, grupos do `which-key`, plugins e opções desta configuração (Neovim `0.12+` com `lazy.nvim`).

---

## Teclas Líderes e Atalhos Gerais

| Atalho | Modo | Ação | Origem |
|---|---|---|---|
| `<Space>` | — | `<leader>` global | `lua/config/keymaps.lua` |
| `\` | — | `<localleader>` global | `lua/config/keymaps.lua` |
| `<Esc>` | Normal | Limpar destaque de busca (`:nohlsearch`) | `lua/config/keymaps.lua` |
| `<leader>?` | Normal | Exibir atalhos locais do buffer (`which-key`) | `lua/plugins/which-key.lua` |

### Grupos configurados no `which-key`

| Prefixo | Modos | Grupo |
|---|---|---|
| `<leader>c` | Normal, Visual | CMake / Código |
| `<leader>f` | Normal | Buscar (Telescope) |
| `<leader>g` | Normal | Git (Fugitive) |
| `<leader>r` | Normal | Refatorar |
| `<leader>t` | Normal | Alternar |
| `gr` | Normal, Visual | LSP (nativo) |

---

## Explorador de Arquivos (`snacks.explorer`)

Configurado em `lua/plugins/snacks.lua` com `replace_netrw = false` (mantém o `netrw` padrão ao abrir diretórios), exibindo arquivos ocultos (`hidden = true`), ocultando arquivos do `.gitignore` por padrão (`ignored = false`), acompanhando o buffer atual (`follow_file = true`) e mantendo a barra aberta após abrir um arquivo (`auto_close = false`).

### Atalho Global

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>e` | Normal | Alternar barra lateral do explorador de arquivos |

### Atalhos Principais Dentro do Explorador

| Atalho | Ação |
|---|---|
| `<CR>` / `l` | Abrir arquivo ou expandir/recolher diretório |
| `h` | Recolher diretório / voltar ao diretório pai |
| `a` | Criar arquivo ou diretório (termine com `/` para criar pasta) |
| `r` | Renomear |
| `d` | Deletar (move para a lixeira do sistema via `gio`) |
| `c` / `m` / `p` | Copiar / Mover / Colar |
| `H` | Alternar exibição de arquivos ocultos (dotfiles) |
| `I` | Alternar exibição de arquivos ignorados pelo `.gitignore` |
| `/` | Filtrar itens na árvore |
| `<C-v>` / `<C-s>` | Abrir arquivo em split vertical / horizontal |
| `?` | Exibir todos os atalhos internos do explorador |

---

## Busca e Navegação (`telescope.nvim`)

Configurado em `lua/plugins/telescope.lua` com aceleração via `telescope-fzf-native.nvim`.

| Atalho | Modo | Ação | Comando |
|---|---|---|---|
| `<leader>ff` | Normal | Buscar arquivos no projeto | `:Telescope find_files` |
| `<leader>fg` | Normal | Buscar texto no projeto | `:Telescope live_grep` |
| `<leader>fb` | Normal | Listar buffers abertos | `:Telescope buffers` |
| `<leader>fh` | Normal | Buscar na documentação/ajuda | `:Telescope help_tags` |
| `<leader>fd` | Normal | Listar diagnósticos | `:Telescope diagnostics` |

---

## LSP e Diagnósticos

Configurado em `lua/config/lsp.lua`, `lua/plugins/lsp.lua` e `after/lsp/`.

- **Servidores habilitados automaticamente** (quando o executável existe no `$PATH`):
  - `clangd` (`after/lsp/clangd.lua`): C, C++, Objective-C, Objective-C++, CUDA (`--background-index`, `--clang-tidy`, `--header-insertion=iwyu`, `--completion-style=detailed`).
  - `lua_ls` (`after/lsp/lua_ls.lua`): Lua + API do Neovim e plugins via `lazydev.nvim` (`vim.uv` e `Snacks`).
- **Recursos ativos por padrão:** diagnósticos inline (`virtual_text = true`, ordenados por severidade, janelas flutuantes arredondadas), **Inlay Hints** e **CodeLens**.

### Atalhos Customizados (`LspAttach`)

| Atalho | Modo | Ação | Observação |
|---|---|---|---|
| `gd` | Normal | Ir para definição | Buffers com LSP |
| `gD` | Normal | Ir para declaração | Buffers com LSP |
| `gi` | Normal | Ir para implementação | Buffers com LSP |
| `<leader>rn` | Normal | Renomear símbolo | Buffers com LSP |
| `<leader>ca` | Normal, Visual | Ações de código (`code_action`) | Buffers com LSP |
| `<leader>cf` | Normal | Formatar buffer (assíncrono) | Buffers com LSP |
| `<leader>d` | Normal | Abrir float com detalhes do diagnóstico | Buffers com LSP |
| `<leader>ch` | Normal | Alternar Header / Source | Apenas `clangd` |
| `<leader>th` | Normal | Alternar Inlay Hints | Quando suportado pelo servidor |

### Atalhos Nativos do Neovim 0.12+ (Preservados)

| Atalho | Modo | Ação |
|---|---|---|
| `grr` | Normal | Listar referências |
| `grn` | Normal | Renomear símbolo |
| `gra` | Normal, Visual | Ações de código |
| `gri` | Normal | Ir para implementação |
| `grt` | Normal | Ir para definição de tipo |
| `grx` | Normal | Executar CodeLens |
| `K` | Normal | Documentação sob o cursor (Hover) |
| `[d` / `]d` | Normal | Ir para diagnóstico anterior / próximo |

---

## CMake — C / C++ (`cmake-tools.nvim`)

Configurado em `lua/plugins/cpp-cmake.lua` (carregado para `c`, `cpp` e `cmake`, com diretório de build `build` e geração automática de `compile_commands.json`).

| Atalho | Modo | Ação | Comando |
|---|---|---|---|
| `<leader>cg` | Normal | Gerar projeto | `:CMakeGenerate` |
| `<leader>cG` | Normal | Gerar projeto do zero (`--fresh`) | `:CMakeGenerate!` |
| `<leader>cb` | Normal | Compilar target | `:CMakeBuild` |
| `<leader>cB` | Normal | Limpar e recompilar (`--clean-first`) | `:CMakeBuild!` |
| `<leader>cr` | Normal | Executar target | `:CMakeRun` |
| `<leader>cd` | Normal | Depurar target | `:CMakeDebug` |
| `<leader>cq` | Normal | Parar tarefa em execução | `:CMakeStopExecutor` |
| `<leader>ct` | Normal | Selecionar target de build | `:CMakeSelectBuildTarget` |
| `<leader>cp` | Normal | Selecionar preset de configuração | `:CMakeSelectConfigurePreset` |
| `<leader>cs` | Normal | Selecionar tipo de build | `:CMakeSelectBuildType` |
| `<leader>cc` | Normal | Limpar artefatos de build | `:CMakeClean` |

---

## Git (`vim-fugitive`)

Configurado em `lua/plugins/oneliners.lua` (carregamento lazy por comandos ou atalhos).

| Atalho | Modo | Ação | Comando |
|---|---|---|---|
| `<leader>gs` | Normal | Abrir status do Git | `:Git` |
| `<leader>gd` | Normal | Diff vertical do arquivo atual | `:Gvdiffsplit` |
| `<leader>gb` | Normal | Git blame do arquivo atual | `:Git blame` |
| `<leader>gl` | Normal | Últimos 20 commits resumidos | `:Git log --oneline -n 20` |
| `<leader>gc` | Normal | Criar commit | `:Git commit` |
| `<leader>gp` | Normal | Enviar commits (`push`) | `:Git push` |

Comandos adicionais disponíveis: `:Git`, `:G`, `:Gdiffsplit`, `:Gvdiffsplit`, `:Gread`, `:Gwrite`.

---

## Autocompletar (`blink.cmp`)

Configurado em `lua/plugins/completion.lua` com `keymap = { preset = "default" }`, `friendly-snippets`, `ghost_text`, documentação automática (delay de `200ms`), ajuda de assinatura (`signature`) e fontes `lazydev`, `lsp`, `path`, `snippets` e `buffer`.

| Atalho | Modo | Ação |
|---|---|---|
| `<C-space>` | Inserção | Abrir menu de completação / alternar documentação |
| `<C-y>` | Inserção | Aceitar sugestão selecionada |
| `<C-e>` | Inserção | Fechar/cancelar menu |
| `<C-p>` / `<C-n>` | Inserção | Item anterior / próximo (também `<Up>` / `<Down>`) |
| `<C-b>` / `<C-f>` | Inserção | Rolar janela de documentação para cima / baixo |
| `<Tab>` / `<S-Tab>` | Inserção | Avançar / voltar entre posições de snippet |
| `<C-k>` | Inserção | Alternar ajuda de assinatura (`signature help`) |

---

## Plugins Visuais e Automáticos (Sem Atalhos Dedicados)

| Plugin | Arquivo | Função |
|---|---|---|
| `folke/tokyonight.nvim` | `lua/plugins/colors.lua` | Tema de cores principal (`tokyonight`) |
| `nvim-mini/mini.icons` | `lua/plugins/colors.lua` | Ícones unificados (emula `nvim-web-devicons` para `lualine`, `telescope`, `which-key` e `snacks`) |
| `nvim-lualine/lualine.nvim` | `lua/plugins/colors.lua` | Barra de status com tema `tokyonight` |
| `nvim-treesitter/nvim-treesitter` (`main`) | `lua/plugins/treesitter.lua` | Highlight e indentação nativos do Neovim 0.12+ (parsers: `lua`, `c`, `cpp`, `cmake`, `markdown`, `markdown_inline`, `vim`, `vimdoc`) |
| `brenoprata10/nvim-highlight-colors` | `lua/plugins/oneliners.lua` | Destaca códigos de cores CSS/hex diretamente no buffer |
| `folke/lazydev.nvim` | `lua/plugins/lsp.lua` | Completação e tipagem da API Lua do Neovim e plugins (`vim.uv`, `Snacks`) |

---

## Opções Principais do Editor

Definidas em `init.lua` e `lua/config/options.lua`:

- **Interface:** `ui2` experimental do Neovim 0.12+ (com fallback seguro), `termguicolors = true`, `signcolumn = "yes"`, `number = true`, `relativenumber = true`, `cursorline = true`, `scrolloff = 8`.
- **Indentação:** `expandtab = true`, `shiftwidth = 2`, `tabstop = 2`, `smartindent = true`.
- **Busca:** `ignorecase = true`, `smartcase = true`.
- **Comportamento e Janelas:** `undofile = true`, `clipboard = "unnamedplus"` (com suporte nativo a OSC 52 via SSH), `updatetime = 250`, `splitright = true`, `splitbelow = true`.
- **Providers desativados:** Node, Perl e Ruby (`loaded_*_provider = 0`).
- **Gerenciador de plugins (`lua/config/lazy.lua`):** `lazy.nvim` com `rocks.enabled = false` e verificação silenciosa de atualizações (`checker.enabled = true, notify = false`).

---

## Estrutura dos Arquivos

```text
~/.config/nvim/
├── init.lua                    # Ponto de entrada (ui2, providers, carregamento dos módulos)
├── keymap.md                   # Este guia de referência
├── CHANGELOG.md                # Histórico de alterações da configuração
├── lazy-lock.json              # Versões travadas dos plugins pelo lazy.nvim
├── after/
│   └── lsp/
│       ├── clangd.lua          # Sobrescritas do servidor clangd
│       └── lua_ls.lua          # Sobrescritas do servidor lua_ls
└── lua/
    ├── config/
    │   ├── keymaps.lua         # Líderes (<Space>, \) e atalhos básicos
    │   ├── lazy.lua            # Bootstrap e setup do lazy.nvim
    │   ├── lsp.lua             # Diagnósticos, capabilities, LspAttach e vim.lsp.enable
    │   └── options.lua         # Opções do editor
    └── plugins/
        ├── colors.lua          # tokyonight, mini.icons, lualine
        ├── completion.lua      # blink.cmp + friendly-snippets
        ├── cpp-cmake.lua       # cmake-tools.nvim
        ├── lsp.lua             # nvim-lspconfig + lazydev.nvim
        ├── oneliners.lua       # vim-fugitive + nvim-highlight-colors
        ├── snacks.lua          # snacks.nvim (explorer vertical)
        ├── telescope.lua       # telescope.nvim + fzf-native
        ├── treesitter.lua      # nvim-treesitter (branch main)
        └── which-key.lua       # which-key.nvim e grupos de atalhos
```
