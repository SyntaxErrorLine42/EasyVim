-- Local variavles for cleaner code
local map = vim.keymap.set
local api = vim.api

-- Easy mappings for one click command access
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", ",", ":", { desc = "CMD enter command mode" })

-- Easier ESC (can also map your CAPS LOCK to ESC on OS level with this command: 'setxkbmap -option caps:escape')
map("i", "jk", "<ESC>")
map("s", "jk", "<ESC>")

-- Great way to manager your copy and pasting, by default the system clipboard is not synced with vim default register, but we
-- are gonna map all the copying straight to the clipboard, but the pasting is not connected to clipboard, if we need to paste something from
-- clipboard, we can do so with <CS-v> while we can also use the default vim register for in buffer actions like 'dd'
map({ "n", "v" }, "y", '"+y', { noremap = true, silent = true })
map("n", "Y", '"+Y', { noremap = true, silent = true })

-- Fast solution for selecting everything in current buffer, also copying everything from the buffer
map({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG$", { noremap = true, silent = true, desc = "Select all" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- Fast solution for replacing everything in a file or replacing just the highlighted part
map("n", "<C-q>", "ggVG\"+p", { noremap = true, silent = true, desc = "Replace all" })
map("v", "<C-q>", 'x"+p', { noremap = true, silent = true, desc = "Replace selected" })

-- The best type of terminal is the one you can toggle, and you can do it with this mapping. If you want to exit terminal input you use <C-x> than you
-- can use <C-h/j/k/l> to move around between windows like usual
map({ "n", "t" }, "<CS-j>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

local term_buf
local term_win

map({"n", "t"}, "<C-S-j>", function()
  if term_win and api.nvim_win_is_valid(term_win) then
    -- if terminal visible, hide it
    api.nvim_win_hide(term_win)
    term_win = nil
  else
    -- if buffer exists, show it; else create new terminal
    if term_buf and api.nvim_buf_is_valid(term_buf) then
      vim.cmd("16split")
      term_win = api.nvim_get_current_win()
      api.nvim_win_set_buf(term_win, term_buf)
      vim.cmd("startinsert")
    else
      vim.cmd("16split | terminal")
      term_win = api.nvim_get_current_win()
      term_buf = api.nvim_get_current_buf()
      vim.cmd("startinsert")
    end
  end
end, { noremap = true, silent = true })
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })


-- Fast solution for moving a single line
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Faster way of moving a block of lines
map("n", "<", "<<")
map("n", ">", ">>")

-- If you wanna use this you can keep it (don't be a pussy, use :w)
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Similar to i3 movements but with CTRL, you can change it with 'A' for alt, but i personaly already use Alt for i3 config
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- Easier movement in insert mode for quick adjustments
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- Break undo blocks on space and Enter in insert mode, game-changer honestly
map('i', ' ', '<C-G>u ', { noremap = true, silent = true })
-- map('i', '<CR>', '<C-G>u<CR>', { noremap = true, silent = true }) -- THIS SHIT doesn't work, if anyone figures out why please make a pull request or open an issue
                                                                  -- Like it literally works for everything else but <CR>, maybe it't getting overwritten by something but
                                                                  -- :verbose map <CR> shows nothing i honestly don't know
-- map('i', '<Esc>', '<C-G>u<Esc>', { noremap = true, silent = true })
-- map('i', '<C-c>', '<C-G>u<Esc>', { noremap = true, silent = true })
-- map('i', 'jk', '<C-G>u<Esc>', { noremap = true, silent = true })
-- map('n', 'o', 'g<C-G>uo', { noremap = true, silent = true }) -- This messes up the LuaSnip
-- map('n', 'O', 'g<C-G>uO', { noremap = true, silent = true }) -- This too, don't use it if you like autocompletions

-- When you wanna remove the highlights after searching
vim.keymap.set('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true })
