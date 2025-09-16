-- This file is where it all starts, when opening up nvim the default config file that nvim pulls is ~/.config/nvim/init.lua

-- This is where your plugin theme colors will be saved, HAS to be put before Lazy init
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

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

-- This loads all of the base46 colors at load, has to be after Lazy init
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end

-- I disabled the vim loader, vim loader is making sure the nvim is loading up some aspects from cache, it was experimental in 0.9 and defaulted in 0.10, but we are in 0.11 now and IT STILL CAUSES SOME GLITCHES, for example sometimes the path to a cache is too long so some Linux file systems can't load it up
-- It makes the startup slower by an unnoticeable amount, this shit is already blazing fast
vim.loader.enable(false)
