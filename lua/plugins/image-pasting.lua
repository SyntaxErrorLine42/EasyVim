return {
	-- support for image pasting, use with ":PasteImage", very good for md files, it autocreates "assets" folder and inserts the file
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	opts = {
		-- recommended settings
		default = {
			embed_image_as_base64 = false,
			prompt_for_file_name = false,
			drag_and_drop = {
                enabled = true,
				insert_mode = true,
			},
		},
	},
}
