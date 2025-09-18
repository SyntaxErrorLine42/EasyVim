-- This is the community version of "null_ls" which is actually an unbelieveble plugin. It basically makes the formaters and diagnostics ACT like an LSP while not being actually an LSP
-- Some LSPs like Clangd that i use all the time actually have all of this already installed but there are some languages that don't have everything (completions, linting, diagnostics, formatting) so this is a great way of filling up that hole
-- For example, there is Prettier formatting plugin, you can download it off the Mason menu and you source it here in the none-ls in the null_ls setup and that makes your nvim communicate with the Prettier like it was an LSP, but just for formating (so instead of calling the Prettier command yourself it overrides the vim.lsp.buf.format function)
return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- null_ls.builtins.formatting.stylua,
          -- null_ls.builtins.formatting.prettier,
          -- null_ls.builtins.diagnostics.erb_lint,
          -- null_ls.builtins.diagnostics.rubocop,
          -- null_ls.builtins.formatting.rubocop,
        },
      })

      -- vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {}) -- I already added this in the lsp-configuration.lua but this is just for reference
    end,
  },
  -- Because of this next plugin, you don't have to change any code, you just download the formatter and THAT IS IT, cool as fuck
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      -- Setup Mason
      require("mason").setup()

      -- Setup mason-null-ls
      require("mason-null-ls").setup({
        ensure_installed = {
          -- "black",                         -- Python formatter
          -- "prettier",                      -- JS/TS/HTML/CSS formatter
          -- "stylua",                        -- Lua formatter
          -- "rubocop",                       -- Ruby formatter/linter
        },
        automatic_installation = true,     -- auto-install if missing
        handlers = {},                     -- You need this to get default options
      })
    end,
  },
}
