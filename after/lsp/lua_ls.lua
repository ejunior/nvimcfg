-- Sobrescritas do lua_ls carregadas automaticamente pelo Neovim 0.11+/0.12 (after/lsp/lua_ls.lua)
-- Tipos da API do Neovim e plugins são fornecidos automaticamente pelo lazydev.nvim
---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
      },
      codeLens = { enable = true },
      hint = { enable = true, semicolon = "Disable" },
    },
  },
}
