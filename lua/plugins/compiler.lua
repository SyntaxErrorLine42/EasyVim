return {
	{
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
		opts = {},
		keys = {
			{ "<F5>", "<cmd>CompilerOpen<cr>", desc = "Open Compiler" }, -- Run the code
			{ "<Leader>rs", "<cmd>CompilerStop<cr>", desc = "Stop Compiler" }, -- Stop the code
			-- { "<leader>cr", "<cmd>CompilerRedo<cr>", desc = "Redo Compiler" },
			{ "<leader>rt", "<cmd>CompilerToggleResults<cr>", desc = "Toggle Compiler Results" }, -- Run toggle
		},
	},
	{
		-- This plugin is like a "job manager", it pretty much does what we tell him to and it creates windows and jobs for it
		-- We use the compiler.nvim plugin to automatically make compiler jobs and assign windows to them
		-- Without that plugin we would have to create rules for every single language we wanna compile
		"stevearc/overseer.nvim",
		commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		opts = {
			-- These are settings for the Compile window
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
				-- We have to remove these default bindings since they overlap with ours
				bindings = {
					["<C-v>"] = false,
					["<C-s>"] = false,
					["<C-l>"] = false,
					["<C-h>"] = false,
					["<C-q>"] = false,
					["<C-f>"] = false,
					["<C-e>"] = false,
					["<C-k>"] = false,
					["<C-j>"] = false,
				},
			},
		},
	},
}
