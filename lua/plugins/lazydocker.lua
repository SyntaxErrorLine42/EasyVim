return {
  "crnvl96/lazydocker.nvim",
  -- Lazy-load when the keymap is pressed
  keys = {
    {
      "<leader>ld",
      function()
        require("lazydocker").toggle({ engine = "docker" })
      end,
      desc = "LazyDocker (docker)",
    },
  },
  config = function()
    require("lazydocker").setup({
      window = {
        settings = {
          width = 0.8,         -- Percentage of screen width (0 to 1)
          height = 0.8,        -- Percentage of screen height (0 to 1)
          border = "rounded",  -- See ':h nvim_open_win' border options
          relative = "editor", -- See ':h nvim_open_win' relative options
        },
      },
    })
  end,
}
