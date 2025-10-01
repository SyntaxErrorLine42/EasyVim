return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")

    -- Grab the default config so we don’t wipe out the other sections
    local config = require("lualine").get_config()

    config.sections.lualine_a = {
      {
        "mode",
        fmt = function(str)
          -- return " " .. str -- prepend Vim logo icon, so it looks cooler
          return " " .. str -- this one cool af too
        end,
      },
    }

    -- Override just the lualine_a section to show absolute file path
    config.sections.lualine_c = {
      {
        "filename",
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    }

    -- Now apply the config
    lualine.setup({
      options = {
        -- Check https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md for all themes
        theme = "horizon",
        globalstatus = true, -- This makes it so that the entire nvim session uses one LuaLine
        icons_enabled = true,
      },
      sections = config.sections, -- keep defaults + our filename change
    })
  end,
}
