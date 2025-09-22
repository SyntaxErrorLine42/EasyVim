-- Goated plugin, makes your lua configs recognize nvim runtime and it also gives you nvim completions for your lua_ls LSP
-- We could have done this in lsp-configuration but it works either way
return {
  "folke/lazydev.nvim",
  ft = "lua",   -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
