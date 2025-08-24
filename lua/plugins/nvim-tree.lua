return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- Keymaps
		vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree: Toggle window" }) -- Main nvim-tree Toggle
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "NvimTree: Focus window" }) -- Switch focus to it when opened, also opens if closed

    -- We save the nvim tree api to a variable for reusability

    local api = require("nvim-tree.api")
    -- Open in horizontal split
  	vim.keymap.set("n", "h", api.node.open.horizontal, { desc = "Open in horizontal split" })

  	-- Open in vertical split
  	vim.keymap.set("n", "v", api.node.open.vertical, { desc = "Open in vertical split" })

    -- This is a mapping that turns 'l' into "Open file without switching focus" because not a single person in the world uses the native preview function, you have telescope for that
    -- 'l' as in 'Look', just a memory trick, also l is close to j and k for browsing files
    vim.keymap.set("n", "l", function()
        api.node.open.edit()
        api.tree.focus()
    end, { desc = "Open file and keep focus on tree" })


		-- Setup
		require("nvim-tree").setup({
			filters = { dotfiles = false }, -- Hide/show specific files
			disable_netrw = true, -- Disable NeoVim default file explorer
			hijack_cursor = true, -- Moves the cursor to the tree when it opens
			sync_root_with_cwd = true, -- This one is hella important, you want to sync the current nvim session with the current directory in terminal
			update_focused_file = {
				enable = true, -- Personal preference, when opening a new buffer without the tree, tree cursor stays where you left it
				update_root = false, -- You don't wanna update the directory every time you move one
			},
			view = {
				width = 30, -- Set up width of the window
				preserve_window_proportions = true, -- Doesn't change it's size when moving different windows
			},
			renderer = {
				root_folder_label = false, -- Shows the root folder, pure personal preference
				highlight_git = true, -- Shows git highlights
				indent_markers = { enable = true }, -- Pure visual effect, shows lines like | and _ to show the tree
				-- icons = {        -- You can customize it as you wish
				-- 	glyphs = {
				-- 		default = "󰈚",
				-- 		folder = {
				-- 			default = "",
				-- 			empty = "",
				-- 			empty_open = "",
				-- 			open = "",
				-- 			symlink = "",
				-- 		},
				-- 		git = { unmerged = "" },
				-- 	},
				-- },
			},
		})
	end,
}
