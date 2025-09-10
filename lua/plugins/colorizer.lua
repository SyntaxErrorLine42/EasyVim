return {
  -- Just a simple plugin for color preview when writing hex
  "catgoose/nvim-colorizer.lua",
  event = { "BufReadPre" , "BufNewFile" },
  opts = {
    user_default_options = {
      mode = "virtualtext",
      virtualtext = "󱓻", -- You need nerd fonts for this, otherwise use this: "■"
      virtualtext_inline = "before",
    },
  },
}
