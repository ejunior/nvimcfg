-- Atalho local para acessar as opções do Neovim em Lua
local opt = vim.opt

-- Numeração de linhas e cursor
opt.number = true          -- Exibe o número absoluto da linha na margem esquerda
opt.relativenumber = true  -- Exibe a distância numérica relativa em relação à linha atual do cursor
opt.cursorline = true      -- Destaca a linha atual do cursor
opt.scrolloff = 8          -- Mantém 8 linhas de contexto acima/abaixo do cursor ao rolar

-- Indentação e tabulação
opt.expandtab = false      -- Converte a tecla Tab em espaços em branco em vez de caractere \t
opt.shiftwidth = 2         -- Define 2 espaços para operações de indentação automática (>> e <<)
opt.tabstop = 2            -- Define 2 espaços como largura visual de um caractere Tab (\t)
opt.smartindent = true     -- Ajusta a indentação automaticamente ao quebrar linhas em blocos de código

-- Busca
opt.ignorecase = true      -- Ignora maiúsculas/minúsculas na busca por padrão
opt.smartcase = true       -- Passa a diferenciar maiúsculas/minúsculas se a busca contiver maiúsculas

-- Interface e aparência
opt.termguicolors = true   -- Habilita cores RGB de 24 bits (true color) no terminal
opt.signcolumn = "yes"     -- Mantém a coluna de sinais (LSP/Git) sempre visível para evitar deslocamento do texto

-- Comportamento, histórico e janelas
opt.undofile = true        -- Persiste o histórico de desfazer (undo) entre sessões
opt.clipboard = "unnamedplus" -- Sincroniza com o clipboard do sistema (usa OSC 52 nativo via SSH)
opt.updatetime = 250       -- Tempo de inatividade (ms) para disparar eventos internos e atualizar sinais/swap
opt.splitright = true      -- Abre novas divisões verticais (:vsplit) à direita da janela atual
opt.splitbelow = true      -- Abre novas divisões horizontais (:split) abaixo da janela atual
