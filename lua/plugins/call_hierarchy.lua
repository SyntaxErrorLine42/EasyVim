return {
    -- This is an amazing plugin that shows you call hierarchy in telescope window, but with nested view
    -- Use "s" to toggle between incoming and outgoing calls
	"jmacadie/telescope-hierarchy.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	keys = {
		{
			"<leader>ch",
			"<cmd>Telescope hierarchy incoming_calls<cr>",
			desc = "LSP: [C]all [H]ierarchy",
		},
	},
	opts = {
		-- don't use `defaults = { }` here, do this in the main telescope spec
		extensions = {
			hierarchy = {
				initial_multi_expand = true,
			},
			-- no other extensions here, they can have their own spec too
		},
	},
	config = function(_, opts)
		-- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
		-- configs for us. We won't use data, as everything is in it's own namespace (telescope
		-- defaults, as well as each extension).
		require("telescope").setup(opts)
		require("telescope").load_extension("hierarchy")
	end,
}
