-- This plugin is amazing, you literally get entire LeetCode UI in your session
-- I see no point in making keymaps here since it is really not something you will be running all the time, so to keep the keymaps not cluttered, here are the commands:
-- ":Leet" -> Start LeetCode UI
-- ":Leet run" -> Run LeetCode tests
-- ":Leet submit" -> Submit LeetCode problem
return{
    "kawre/leetcode.nvim",
    cmd = "Leet",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
        -- include a picker of your choice, see picker section for more details
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-treesitter/nvim-treesitter", -- You need this so the build command can run
    },
    opts = {
        -- configuration goes here
    },
}
