-- Configuração nativa de diagnósticos (no Neovim 0.11+/0.12, virtual_text vem desativado por padrão)
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
  },
})

-- Propaga as capabilities do blink.cmp para todos os servidores LSP (se instalado)
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
  vim.lsp.config("*", {
    capabilities = blink.get_lsp_capabilities(),
  })
end

-- Atalhos e recursos nativos anexados quando qualquer servidor LSP se conecta ao buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    -- Navegação (preserva os padrões 0.12+: grr, grn, gra, gri, grt, grx, K, [d, ]d)
    map("n", "gd", vim.lsp.buf.definition, "Ir para definição")
    map("n", "gD", vim.lsp.buf.declaration, "Ir para declaração")
    map("n", "gi", vim.lsp.buf.implementation, "Ir para implementação")

    -- Atalhos convenientes com <leader> (sem conflito com CMake <leader>cd)
    map("n", "<leader>rn", vim.lsp.buf.rename, "Renomear símbolo")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Ações de código")
    map("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "Formatar buffer")
    map("n", "<leader>d", vim.diagnostic.open_float, "Detalhes do diagnóstico")

    -- Atalho específico do clangd (sem sobrescrever o on_attach do nvim-lspconfig)
    if client and client.name == "clangd" then
      map("n", "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<CR>", "Alternar Header / Source")
    end

    -- Inlay hints (se suportado pelo servidor)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
      map("n", "<leader>th", function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
      end, "Alternar Inlay Hints")
    end

    -- CodeLens (se suportado pelo servidor)
    if client and client:supports_method("textDocument/codeLens") then
      vim.lsp.codelens.enable(true, { bufnr = event.buf })
    end
  end,
})

-- Habilita automaticamente os servidores cujos executáveis estejam disponíveis no $PATH
-- Sobrescritas de configuração vivem em after/lsp/<servidor>.lua
local servers = {
  clangd = "clangd",
  lua_ls = "lua-language-server",
}

local enabled_servers = {}
for server, bin in pairs(servers) do
  if vim.fn.executable(bin) == 1 then
    table.insert(enabled_servers, server)
  end
end

if #enabled_servers > 0 then
  vim.lsp.enable(enabled_servers)
end
