return {
  {
    -- Git plugin (:Git)
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git: Status" },
      { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git: Diff vertical" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git: Blame" },
      { "<leader>gl", "<cmd>Git log --oneline -n 20<cr>", desc = "Git: Log recente" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git: Commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git: Push" },
    },
  },
  {
    -- Destaca cores CSS/hex no buffer
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
