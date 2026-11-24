return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-mini/mini.icons",
    },
    opts = {
      spec = {
        { "<leader>c", group = "CMake / Código", mode = { "n", "v" } },
        { "<leader>f", group = "Buscar (Telescope)" },
        { "<leader>g", group = "Git (Fugitive)" },
        { "<leader>r", group = "Refatorar" },
        { "<leader>t", group = "Alternar" },
        { "gr", group = "LSP (nativo)", mode = { "n", "v" } },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Atalhos locais do buffer (which-key)",
      },
    },
  },
}
