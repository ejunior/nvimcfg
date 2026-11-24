return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "nvim-mini/mini.icons",
    version = false,
    lazy = true,
    opts = {},
    init = function()
      -- Emula nvim-web-devicons para que lualine, telescope e outros plugins usem mini.icons
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-mini/mini.icons",
    },
    opts = {
      options = {
        theme = "tokyonight",
      },
    },
  },
}
