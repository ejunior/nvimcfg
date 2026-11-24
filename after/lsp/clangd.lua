-- Sobrescritas do clangd carregadas automaticamente pelo Neovim 0.11+/0.12 (after/lsp/clangd.lua)
-- Não define on_attach para preservar o comando :LspClangdSwitchSourceHeader do nvim-lspconfig
---@type vim.lsp.Config
return {
  cmd = {
    "clangd",
    "--background-index",      -- Indexa o projeto em segundo plano
    "--clang-tidy",            -- Habilita análise estática do clang-tidy
    "--header-insertion=iwyu", -- Insere #include automaticamente na completação
    "--completion-style=detailed",
  },
  -- Sobrescreve os filetypes do nvim-lspconfig para evitar warnings de filetypes compostos ('c.doxygen', 'cpp.doxygen') no :checkhealth vim.lsp
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".clangd",
    ".git",
  },
}
