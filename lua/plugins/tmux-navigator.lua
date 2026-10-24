-- This is one of the best plugins there is, it is very lightweight, here is what is does:
-- If you are a tmux user, you know how hard it is to switch between panes between tmux and nvim, we use <C-l> or <C-r> for swapping windows in neovim, but in tmux you need a prefix
-- This plugin removes the tmux prefix and you can switch panes just as if the tmux pane was a nvim terminal
-- You also need to set up tmux.conf, if you are using 'tpm' tmux package manager, just add "set -g @plugin 'christoomey/vim-tmux-navigator'" in your config
-- Refer to their GitHub page for more info: https://github.com/christoomey/vim-tmux-navigator
-- But yeah, this plugin is fucking OP
-- If you use Neovim integrated terminals, there is a command insertion bug fixed by this guy https://github.com/christoomey/vim-tmux-navigator/issues/469
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
	init = function()
		local function set_maps()

			vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
			vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
			vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
			vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })

			if vim.bo.buftype == "terminal" and vim.b.my_custom_terminal then
				vim.keymap.set("t", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true, buffer = true })
				vim.keymap.set("t", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true, buffer = true })
				vim.keymap.set("t", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true, buffer = true })
				vim.keymap.set("t", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true, buffer = true })
			end
		end

		set_maps()
		vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, { callback = set_maps })
	end,
}
