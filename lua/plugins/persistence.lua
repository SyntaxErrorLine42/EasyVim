-- Great plugin for managing sessions per dirs (also compatible with having multiple git branches)
-- Saves sessions in ~/.local/state/nvim/sessions
-- Also very lightweight
return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- lazy-loads before reading a buffer
  opts = {}, -- default options
  keys = {
    -- { "<leader>sr", function() require("persistence").load() end, desc = "Restore Session" },
    { "<leader>se", function() require("persistence").select() end, desc = "Select Session (Session enter)" },
    { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    -- { "<leader>sd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    { "<leader>ss", function() require("persistence").select() end, desc = "Save session manually with prompt" },
  },
}
