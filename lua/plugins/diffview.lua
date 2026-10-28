local function toggle_folds()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.wo[win].diff then
			vim.wo[win].foldenable = not vim.wo[win].foldenable
		end
	end
end

return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewRefresh",
	},
	keys = {
		{
			"<leader>vd",
			function()
				local lib = require("diffview.lib")
				local view = lib.get_current_view()
				if view then
					vim.cmd("DiffviewClose")
				else
					vim.cmd("DiffviewOpen")
				end
			end,
			desc = "Toggle Diffview",
		},
	},
	config = function()
        vim.opt.diffopt:append("context:12")
		require("diffview").setup({
			view = {
				merge_tool = {
					layout = "diff3_mixed",
					disable_diagnostics = true,
				},
			},
			keymaps = {
				file_panel = {
					{ "n", "zi", toggle_folds, { desc = "Toggle folds in diff windows" } },
				},
				file_history_panel = {
					{ "n", "zi", toggle_folds, { desc = "Toggle folds in diff windows" } },
				},
			},
		})
	end,
}
