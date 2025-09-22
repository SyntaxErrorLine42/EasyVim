return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "NvimTree: Toggle window" }, -- Main nvim-tree Toggle
    { "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "NvimTree: Focus window" }, -- Switch focus to it when opened, also opens if closed
  },

	config = function()
		-- Setup
		require("nvim-tree").setup({
			-- Attach buffer-local keymaps when NvimTree opens, THIS IS VERY IMPORTANT, these should be buffer specific which is different than the first 2 maps
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

        -- First, apply the default NvimTree mappings, because when we do on_attach we override the defaults but we still wanna keep stuff like 'r' for renaming or '<CR>' for editing and stuff
        api.config.mappings.default_on_attach(bufnr)

				-- Open in horizontal split
				vim.keymap.set("n", "h", api.node.open.horizontal, { desc = "Open in horizontal split", buffer = bufnr })

				-- Open in vertical split
				vim.keymap.set("n", "v", api.node.open.vertical, { desc = "Open in vertical split", buffer = bufnr })

				-- This is a mapping that turns 'l' into "Open file without switching focus" because not a single person in the world uses the native preview function, you have telescope for that
				-- 'l' as in 'Look', just a memory trick, also l is close to j and k for browsing files
				vim.keymap.set("n", "l", function()
					api.node.open.edit()
					api.tree.focus()
				end, { desc = "Open file and keep focus on tree", buffer = bufnr })
			end,
      -- For 'h', 'v' and 'l' mappings the buffer = bufnr is extremely important, when i was first doing this i accidentaly didn't do on_attach and i was confused af when hjkl wasn't working

			filters = {
        dotfiles = false,
        git_ignored = false,
      }, -- Hide/show specific files
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
      -- Shows diagnostics next to the file name in the buffer, unfortunately it only shows for opened buffers and that is just the way LSPs working
      -- LSPs can't scan the files that aren't opened, so you might say "UGH MY VS CODE SHOWS IT IN THE TREE BY DEFAULT" like yeah
      -- That's why it takes 2 hours to load up, we don't need buffers that aren't loaded, we are trading that small inconvenience for speed
      -- I think you have enough diagnostics, they are in the code next to line numbers, you have linting, bufferline diagnostics...
      -- ... and all the LSP functions, Nvim-Tree one is not needed
      -- diagnostics = {
      --   enable = true,
      -- }

      -- Also very useful, there are some nice default mappings that you can use:
      -- a → Create file or directory
      -- d → Delete file or directory
      -- r → Rename file or directory
      -- x → Cut (move) file
      -- c → Copy file
      -- p → Paste file
      -- R → Refresh tree
      -- W → Collapse all
      -- E → Expand all under cursor
      -- H → Toggle hidden dotfiles
      -- I → Toggle ignored files (like .gitignore)
      -- D → Put the file/folder into trash
		})
	end,
}
