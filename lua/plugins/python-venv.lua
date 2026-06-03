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
            -- Disable cache. This means that every time you enter your project it will default to global python
			enable_cached_venvs = false,
			cached_venv_automatic_activation = false,
			require_lsp_activation = false,
		},
	},
}
