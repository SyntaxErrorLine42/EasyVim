-- Todo list plugin, launch with <leader>td
return {
	"atiladefreitas/dooing",
	config = function()
		require("dooing").setup({
			ui = {
				style = "modern",
			},
			window = {
				dimensions = {
					width = 200,
					height = 50,
				},
			},
			due_notifications = {
				enabled = false,
				on_startup = false,
				on_open = false,
			},
		})
	end,
}
