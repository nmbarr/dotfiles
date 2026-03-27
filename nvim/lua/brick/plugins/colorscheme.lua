return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = { style = "moon", transparent = true },
  config = function(_, opts)
    require("tokyonight").setup(opts)

    vim.cmd.colorscheme("tokyonight-moon")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end,
}
