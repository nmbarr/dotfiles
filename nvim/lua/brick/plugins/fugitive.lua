return {
  "tpope/vim-fugitive",
  lazy = false,
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
    vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
    vim.keymap.set("n", "<leader>gl", "<cmd>Git pull<cr>", { desc = "Git pull" })
    vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Git blame" })
    vim.keymap.set("n", "<leader>gd", "<cmd>Git diff<cr>", { desc = "Git diff" })
    vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
  end,
}
