return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	keys = {
		{ "<Leader>ma", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
	},
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	init = function()
		vim.g.mkdp_browserfunc = "OpenMarkdownPreviewApp"
		vim.cmd([[
            function! OpenMarkdownPreviewApp(url)
                if executable('brave-browser')
                    execute "silent ! brave-browser --app=" . shellescape(a:url) . " &"
                else
                    execute "silent ! '/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe' --app=" . shellescape(a:url) . " &"
                endif
            endfunction
        ]])
	end,
}
