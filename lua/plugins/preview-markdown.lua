return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	init = function()
		vim.g.mkdp_browserfunc = "OpenMarkdownPreviewApp"
		vim.cmd([[
		function! OpenMarkdownPreviewApp(url)
		  execute "silent ! brave-browser --app=" . shellescape(a:url) . " &"
		endfunction
		]])
	end,
}
