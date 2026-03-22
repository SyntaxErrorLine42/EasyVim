return {
	-- I can't believe I've just started using this now
    -- Ts goated
	"jiaoshijie/undotree",
	opts = {
		-- your options
	},
	keys = { -- load the plugin only when using it's keybinding:
		{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
	},
}
