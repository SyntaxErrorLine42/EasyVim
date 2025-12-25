-- This is the plugin needed to set up Roslyn LSP for CSharp which replaces the Omnisharp LSP
return {
	"seblyng/roslyn.nvim",
	ft = { "cs", "razor", "blazor" },
	---@module 'roslyn.config'
	---@type RoslynNvimConfig
	opts = {
		-- your configuration comes here; leave empty for default settings
	},
}
