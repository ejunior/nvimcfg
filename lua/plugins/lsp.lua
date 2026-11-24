return {
  {
    -- Carregado cedo para disponibilizar os presets lsp/*.lua antes do vim.lsp.enable()
    "neovim/nvim-lspconfig",
    lazy = false,
  },
  {
    -- Fornece tipos e completação da API Lua do Neovim e plugins para o lua_ls e blink.cmp
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
}
