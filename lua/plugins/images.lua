return{
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    ft = { "markdown" },
    opts = {
        -- sudo apt install ueberzug
        -- I needed this because alacritty term doesn't support images
        -- kitty for example has this built in
        backend = "ueberzug",
        processor = "magick_cli",
    }
}
