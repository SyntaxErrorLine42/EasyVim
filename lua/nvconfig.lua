-- You need this file for base46 to work. You can change themes here, add overrides, customize themes and so on
-- If you wanna make custom themes, put them in /lua/themes/xxx.lua and they have to be in the format described in the https://github.com/NvChad/base46 documentation
-- When you make changes to this file, you have to restart nvim, then call ": lua require("base46").compile(); require("base46").load_all_highlights()"...
-- ...or you can call shortcut <Leader>bc
return{

  base46 = {
    theme = "dark_horizon", -- default theme
    hl_add = {},
    hl_override = { -- Everything that is inside of this hl_override you can comment out since this is adjusted for my theme that I'm using
      FloatBorder = { fg = "#BBBBBB", bg = "NONE" }, -- I use this so it is the same color as my I3 config, it affects the floated windows like completion window
      Normal = { fg = "#BBBBBB" }, -- This is for some other bordering
      NvimTreeWinSeparator = { fg = "#BBBBBB",  }, -- Sorry this just looks too cool
      NvimTreeIndentMarker = { fg = "#404040", }, -- This is because i override the line in dark_horizon, if you don't like comment it out
      -- BufferLineFill = {
      --   sp = "#BBBBBB",
      --   underline = true,
      -- },
    },
    integrations = {"bufferline"}, -- Check out https://github.com/NvChad/base46/blob/v3.0/lua/base46/init.lua to see which ones are defaults (you have to add others)
    changed_themes = {
      dark_horizon = {
        base_30 = {
          line = "#BBBBBB", -- You can override M table in this format, check out https://github.com/NvChad/base46/blob/v3.0/lua/base46/themes/dark_horizon.lua for format
        }
      }
    },
    transparency = false,
    theme_toggle = { "onedark", "one_light" },
    excluded = {"telescope"}, -- Add here what you wanna exclude (if you excluded AFTER applying the plugin, go to base46_cache and delete the unused plugin files)
  },

  -- We are not using any of this, we are disabling all of it, we are using this plugin just for the themes
  ui = {
    cmp = {
      enabled = false,
      icons_left = false, -- only for non-atom styles!
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      abbr_maxwidth = 60,
      -- for tailwind, css lsp etc
      format_colors = { lsp = true, icon = "󱓻" },
    },

    telescope = { enabled = false,
      style = "bordered" }, -- borderless / bordered

    statusline = {
      enabled = false,
      theme = "default", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "default",
      order = nil,
      modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = false,
      lazyload = true,
      order = { "treeOffset", "buffers", "tabs", "btns" },
      modules = nil,
      bufwidth = 21,
    },

    bufferline = {
      enabled = true,
    }
  },

  nvdash = {
    enabled = false,
    load_on_startup = false,
    header = {
      "                      ",
      "  ▄▄         ▄ ▄▄▄▄▄▄▄",
      "▄▀███▄     ▄██ █████▀ ",
      "██▄▀███▄   ███        ",
      "███  ▀███▄ ███        ",
      "███    ▀██ ███        ",
      "███      ▀ ███        ",
      "▀██ █████▄▀█▀▄██████▄ ",
      "  ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀",
      "                      ",
      "  Powered By  eovim ",
      "                      ",
    },

    buttons = {
      { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
      { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
      { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
      { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
      { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

      {
        txt = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime) .. " ms"
          return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
        end,
        hl = "NvDashFooter",
        no_gap = true,
        content = "fit",
      },

      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    },
  },

  term = {
    enabled = false,
    base46_colors = true,
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },

  lsp = { signature = true },

  cheatsheet = {
    enabled = false,
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },

  mason = { pkgs = {}, skip = {} },

  colorify = {
    enabled = false,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}
