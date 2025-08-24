return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true, -- This automatically installs the treesitter for your current file type in the buffer
      highlight = { enable = true }, -- Enable syntax highlighting
      indent = { enable = true }, -- Enable indentation based on syntax
      use_languagetree = true, -- Better support for multi language files, for example HTML with embedeed JS and CSS, HELLA COOL IK IK
    })
  end,
}
