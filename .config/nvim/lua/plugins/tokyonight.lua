return {
  "folke/tokyonight.nvim",
  lazy = false,
  opts = {
    style = "moon",
    transparent = true,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
    vim.api.nvim_set_hl(0, "LineNrAbove", { bold = true })
    vim.api.nvim_set_hl(0, "LineNrBelow", { bold = true })
  end,
}
