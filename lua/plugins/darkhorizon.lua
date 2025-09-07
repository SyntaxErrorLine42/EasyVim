return {
  "lunarvim/horizon.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    overrides = {
      Normal = { bg = "#0e0e0e" },
      NvimTreeNormal = { bg = "#000000" },
    },
  },
  config = function(_, opts)
    require("horizon").setup(opts)
    vim.cmd.colorscheme("horizon")
  end,
}
