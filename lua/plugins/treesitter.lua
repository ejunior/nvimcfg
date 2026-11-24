return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup({})

      local parsers = {
        "lua",
        "c",
        "cpp",
        "cmake",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
      }

      -- Instala parsers faltantes de forma assíncrona após o carregamento do lazy.nvim
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        once = true,
        callback = function()
          local ok, installed_list = pcall(ts.get_installed)
          if ok and type(installed_list) == "table" then
            local installed = {}
            for _, lang in ipairs(installed_list) do
              installed[lang] = true
            end
            local missing = vim.tbl_filter(function(lang)
              return not installed[lang]
            end, parsers)
            if #missing > 0 then
              ts.install(missing)
            end
          else
            ts.install(parsers)
          end
        end,
      })

      -- Ativa highlight e indentação nativos do Neovim 0.12+ via Tree-sitter por FileType
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
        callback = function(event)
          if pcall(vim.treesitter.start, event.buf) then
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
