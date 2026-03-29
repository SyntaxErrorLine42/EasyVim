return {
	-- I can't believe I've just started using this now
	-- Ts goated
	"mbbill/undotree",
	keys = {
		{
            -- This is to toggle it, the function resets the width so we can reset if it gets messed up by nvim tree (dont open nvim tree while the cursor is on undotree lol)
			"<leader>u",
			function()
				vim.cmd.UndotreeToggle()
				-- if it just opened, force the width
				if vim.g.undotree_WindowLayout == 3 then
					vim.schedule(function()
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							local buf = vim.api.nvim_win_get_buf(win)
							local ft = vim.bo[buf].filetype
							if ft == "undotree" or ft == "diff" then
								vim.api.nvim_win_set_width(win, vim.g.undotree_SplitWidth)
							end
						end
					end)
				end
			end,
			desc = "Toggle UndoTree",
		},
	},
	init = function()
		vim.g.undotree_WindowLayout = 3 -- opens on the right side
		vim.g.undotree_SplitWidth = 50 -- default is 30
	end,
}
