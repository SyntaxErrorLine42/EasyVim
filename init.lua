-- This file is where it all starts, when opening up nvim the default config file that nvim pulls is ~/.config/nvim/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- It's important to load the options and mapping before loading up Lazy plugin otherwise you get errors
require("options")
require("mappings")

-- Disable auto-comment continuation for all files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o", "c" }) -- 'r' is for enter, 'o' is for new line, 'c' is for context wrapping
  end,
})

-- Importing lazy into nvim
require("lazy").setup({
    spec = {
        { import = "plugins" }, -- Load the "plugins" map under the "lua" folder
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
})

-- We load and apply the theme (My personal favourite is 'Dark horizon')
local dark_horizon = require("themes.dark_horizon")
dark_horizon.apply()
vim.o.background = dark_horizon.type  -- Set background for other plugins
