return {
	"Fildo7525/pretty_hover",
	event = "LspAttach",
	opts = {
		max_width = 100,
	},
	keys = {
		{
			"K",
			function()
				require("pretty_hover").hover()
			end,
			desc = "Pretty hover",
		},
	},
}
