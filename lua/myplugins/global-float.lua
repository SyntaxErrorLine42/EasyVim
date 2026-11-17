-- Very simple floating window plugin that opens up a "global notes" file
-- Very useful for stuff like Todo list or notes
-- I find this better then other todo plugins since I like having the entire file editable how I like it
local function open_todo()
	local path = vim.g.todo_float_path or vim.fn.stdpath("data") .. "/global_float.md"
	local buf = vim.fn.bufadd(path)
	vim.fn.bufload(buf)
	vim.bo[buf].buflisted = false

	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = math.floor(vim.o.columns * 0.7),
		height = math.floor(vim.o.lines * 0.7),
		row = math.floor(vim.o.lines * 0.15),
		col = math.floor(vim.o.columns * 0.15),
		border = "rounded",
	})

	vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, nowait = true, silent = true })
	vim.keymap.set("n", "<leader>td", "<cmd>close<cr>", { buffer = buf, nowait = true, silent = true })
end

return {
	"global-float",
	virtual = true,
	keys = {
		{ "<leader>td", open_todo, desc = "Open global float" },
	},
}
