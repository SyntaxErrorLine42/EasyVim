-- This plugin is used for inline git signs, all the actual git stuff is being done by lazygit
return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",  -- lazy-load after a file is opened, makes NeoVim startup one millionth of a second faster, hell yeah that's what this is all about
    opts = {
      -- Signs for inline git actions
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "󰍵" },
        topdelete    = { text = "‾" },
        changedelete = { text = "󱕖" },
      },
    },
  },
}

