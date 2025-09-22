-- This is one of the best plugins there is, it is very lightweight, here is what is does:
-- If you are a tmux user, you know how hard it is to switch between panes between tmux and nvim, we use <C-l> or <C-r> for swapping windows in neovim, but in tmux you need a prefix
-- This plugin removes the tmux prefix and you can switch panes just as if the tmux pane was a nvim terminal
-- You also need to set up tmux.conf, if you are using 'tpm' tmux package manager, just add "set -g @plugin 'christoomey/vim-tmux-navigator'" in your config
-- Refer to their GitHub page for more info: https://github.com/christoomey/vim-tmux-navigator
-- But yeah, this plugin is fucking OP
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
