return {
    -- Shows overview of all functions, classes etc.
    -- Very useful default keybinding: "p" is for going to function without moving the cursor from the Aerial view
    "stevearc/aerial.nvim",
    keys = {
        {
            "<leader>a",
            "<cmd>AerialToggle<CR>",
            desc = "Toggle Aerial window",
        },
    },
    config = function()
        require("aerial").setup()
    end,
}
