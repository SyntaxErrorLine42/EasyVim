return {
	-- This plugin automatically finds your python venv and applies it to the terminal and to your LSP
	-- Call ":VenvSelect"
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	ft = "python",
	opts = {
		options = {
			-- Enable cache.
			enable_cached_venvs = true,
			cached_venv_automatic_activation = true,
			require_lsp_activation = true,
		},
	},
    -- Fixes the bug where the global pyenv version carries into nvim session and cached env doesn't activate
	config = function(_, opts)
		require("venv-selector").setup(opts)
		vim.api.nvim_create_autocmd("User", {
			pattern = "VenvSelectActivated",
			callback = function()
				vim.cmd("LspRestart")
			end,
		})
	end,
}
