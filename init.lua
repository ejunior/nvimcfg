-- Ativa o módulo experimental ui2 do Neovim 0.12+ com proteção caso mude em atualizações futuras
local ok_ui2, ui2 = pcall(require, "vim._core.ui2")
if ok_ui2 then
  ui2.enable({})
end

-- Desativa providers não utilizados (ajuste conforme seu uso)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.lsp")
