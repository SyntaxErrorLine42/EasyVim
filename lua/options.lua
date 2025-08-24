-- Local variables for shorter and cleaner code
local opt = vim.opt       -- opt is Luas wrapper for NeoVim options
local o = vim.o           -- Basically the same as having :set
local g = vim.g           -- For global variables

-- Set up SPACE as global <Leader>
g.mapleader = " "

-- Turn tabs into spaces and set indent
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.smartindent = true

-- Enable relative line numbers
opt.relativenumber = true

-- Disables automatic system clipboard
opt.clipboard = ""

-- Nicer screen transitions when creating or closing windows
o.splitkeep = "screen"

-- Nice highlighting, doesn't highlight the entire row but just the number
o.cursorline = true
o.cursorlineopt = "number"

-- The column for lints and git plugins, the little space on the far left of the NeoVim
o.signcolumn = "yes"

-- Standard directions when creating windows
o.splitbelow = true
o.splitright = true

-- Timeout before a key is discarded
o.timeoutlen = 1000

-- Faster update times for plugins
o.updatetime = 250

-- This is for wrapping the cursor at the end and the start of a line, extremely stupid in my opinion but you can uncomment it if you want (don't)
-- opt.whichwrap:append "<>[]hl"

-- Disable nvim startup screen
opt.shortmess:append("sI")

-- Uncomment this if you have low testosterone
-- o.mouse = "a"

-- Numbering, we use relative numbers
o.number = true
o.numberwidth = 2
o.relativenumber = true

-- I really advise you to keep this
o.ignorecase = true       -- This turns on the ignore case when grepping...
o.smartcase = true        -- ...and this makes it so when you do use upper case it doesn't ignore case

-- Exteremly important
o.undofile = true         -- Saved in ~/.local/state/nvim/undo/
o.backup = true         -- Saved in ~/.local/state/nvim/backup/
-- o.writebackup = true    -- Saved in the same path as the file you're writing
-- o.swapfile = true       -- Saved in ~/.local/state/nvim/swap/
-- opt.undolevels = 1000 -- You can also use this if you want to save 10k undos per buffer (might take a lot of space for big projects), default value 1000

