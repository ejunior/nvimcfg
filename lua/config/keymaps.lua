vim.g.mapleader = " "

-- vim.g.maplocalleader = "\\" define a tecla localleader global como a barra invertida (\).
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

--Essa linha cria um atalho de teclado no Neovim para remover o destaque amarelo de buscas (/ ou ?) quando você pressiona Esc no modo Normal.
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Limpar destaque de busca" })
