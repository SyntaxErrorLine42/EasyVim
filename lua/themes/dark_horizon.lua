-- This is a standalone dark_horizon theme plugin for Neovim, it is trying to mimic the NvChad Base46 dark_horizon theme

local M = {}

-- Base 30 colors
M.base_30 = {
  white = "#FFFFFF",
  darker_black = "#080808",
  black = "#0e0e0e", -- nvim bg
  black2 = "#181818",
  one_bg = "#1c1c1c",
  one_bg2 = "#212121",
  one_bg3 = "#292929",
  grey = "#363636",
  grey_fg = "#404040",
  grey_fg2 = "#4a4a4a",
  light_grey = "#525252",
  red = "#db627e",
  baby_pink = "#a72e5b",
  pink = "#ff75a0",
  line = "#1d1d1d",
  green = "#AAD84C",
  vibrant_green = "#b9e75b",
  nord_blue = "#18a3af",
  blue = "#25B0BC",
  seablue = "#169AC9",
  yellow = "#fdb830",
  sun = "#ffc038",
  purple = "#da70d6",
  dark_purple = "#c65cc2",
  teal = "#749689",
  orange = "#FFA500",
  cyan = "#6BE4E6",
  statusline_bg = "#181818",
  lightbg = "#292929",
  pmenu_bg = "#15bf84",
  folder_bg = "#07929e",
}

-- Base 16 colors
M.base_16 = {
  base00 = "#0e0e0e",
  base01 = "#181818",
  base02 = "#292929",
  base03 = "#363636",
  base04 = "#3f4248",
  base05 = "#c9c7be",
  base06 = "#E6E1CF",
  base07 = "#D9D7CE",
  base08 = "#db627e",
  base09 = "#eaa273",
  base0A = "#169AC9",
  base0B = "#E3A587",
  base0C = "#F09483",
  base0D = "#32d5e3",
  base0E = "#6BE4E6",
  base0F = "#d75271",
}

-- Polish highlights (syntax + treesitter)
M.polish_hl = {
  syntax = {
    Include = { fg = M.base_16.base0E, bold = true },
  },
  treesitter = {
    ["@property"] = { fg = M.base_16.base0E },
    ["@tag.delimiter"] = { fg = M.base_16.base05 },
    ["@punctuation.bracket"] = { fg = M.base_30.yellow },
    ["@punctuation.delimiter"] = { fg = M.base_30.yellow },
  },
}

-- Apply highlights
function M.apply()
  -- Syntax highlights
  for group, opts in pairs(M.polish_hl.syntax) do
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Treesitter highlights
  for group, opts in pairs(M.polish_hl.treesitter) do
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- You could also set normal background/foreground
  vim.api.nvim_set_hl(0, "Normal", { fg = M.base_30.white, bg = M.base_30.black })
end

-- Set theme type
M.type = "dark"

return M
