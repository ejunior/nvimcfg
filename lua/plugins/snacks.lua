return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = {
      "nvim-mini/mini.icons",
    },
    ---@type snacks.Config
    opts = {
      explorer = {
        enabled = true,
        replace_netrw = false, -- Mantém o comportamento padrão do netrw ao abrir diretórios
      },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            hidden = true, -- Exibe arquivos ocultos (dotfiles)
            ignored = false, -- Mantém arquivos ignorados pelo git ocultos por padrão (tecla 'I' alterna)
            follow_file = true, -- Acompanha automaticamente o arquivo do buffer atual
            auto_close = false, -- Mantém a barra lateral aberta após abrir um arquivo
          },
        },
      },
      terminal = {
        enabled = true,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "Alternar explorador de arquivos",
      },
      {
        "<C-/>",
        function()
          Snacks.terminal.toggle()
        end,
        mode = { "n", "t" },
        desc = "Alternar terminal",
      },
      {
        "<C-_>",
        function()
          Snacks.terminal.toggle()
        end,
        mode = { "n", "t" },
        desc = "which_key_ignore",
      },
    },
  },
}
