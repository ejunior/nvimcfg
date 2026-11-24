return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Buscar arquivos" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Buscar texto no projeto" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Listar buffers abertos" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Buscar na ajuda" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Listar diagnósticos" },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
