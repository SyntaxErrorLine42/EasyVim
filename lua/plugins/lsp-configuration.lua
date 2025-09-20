-- This is your main space for LSP configuration. It is split into 3 main plugins. First one is "mason" which is the main server side plugin for LSPs, "nvim-lspconfig" is the one that sends requests to the server ("mason") and "mason-lspconfig" is the one that connects them (that is where you are gonna isntall the LSPs)
-- Mason pretty much puts the packages into your PATH
-- HOW TO DOWNLOAD THE LSP:
-- First of all, choose which one you want for your language, you can google some or check the ":Mason" for available ones
-- Then you can install it from ":Mason" page or you can add it to "ensure_installed" list then reload
-- Check with ":checkhealth vim.lsp" to see what LSPs are currently running
return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
      -- event = { "BufReadPost", "BufNewFile" }, -- THIS SHOULD NOT BE UNCOMMENTED, IT BREAKS THE CONFIG, I LEFT IT HERE SO YOU CAN SEE THAT SOMETIMES FASTER IS NOT BETTER
      -- dependencies = { "mason-org/mason.nvim" },
    opts = {
      auto_install = true,
      automatic_enable = true,
      -- ensure_installed = { "clangd", "lua_ls", "ts_ls", "html", "solargraph", "rust_analyzer", "gopls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- This is perfect, you can see with ':checkhealth vim.lsp' that the LSPs aren't loaded, and when you enter buffer it automatically does the set up
    -- THIS MUST NOT BE SET TO BufReadPost!
    -- This config and enable part is just for reference, LSP automatically picks up your Mason installs, this is just if you wanna configure it
    config = function()
      -- TS/JS
      -- vim.lsp.config('tsserver', {})
      -- vim.lsp.enable('tsserver')

      -- Emmet (HTML tags in all languages), OMG PLEASE DO NOT USE emmet_ls, use this one it is 1000000000 times better, emmet_ls is bloated af and gives completions for random stuff, for example you could be typing hello and the main snippet is gonna be <hello></hello> wtfff, this one is so much better
      -- vim.lsp.config('emmet_language_server', {})
      -- vim.lsp.enable('emmet_language_server')

      -- C/C++
      -- vim.lsp.config('clangd', {})
      -- vim.lsp.enable('clangd')

      -- Ruby
      -- vim.lsp.config('solargraph', {})
      -- vim.lsp.enable('solargraph')

      -- HTML
      -- vim.lsp.config('html', {})
      -- vim.lsp.enable('html')

      -- Lua (custom settings)
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.enable('lua_ls')

      -- Rust
      -- vim.lsp.config('rust_analyzer', {})
      -- vim.lsp.enable('rust_analyzer')

      -- Go
      -- vim.lsp.config('gopls', {})
      -- vim.lsp.enable('gopls')

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration)
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references)
      -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action) -- This keymap is set in the telescope-select-ui plugin since we need that to open a nice window
      vim.keymap.set("n", "<leader>ge", function() vim.diagnostic.jump({ count = 1, float = false }) end)
      vim.keymap.set("n", "<leader>gE", function() vim.diagnostic.jump({ count = -1, float = false }) end)
      vim.keymap.set("n", "<Leader>fm", vim.lsp.buf.format)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

      -- Toggle diagnostics
      vim.keymap.set("n", "<Leader>lt", function()
        if vim.g.diagnostics_enabled == nil then
          vim.g.diagnostics_enabled = true
        end
        if vim.g.diagnostics_enabled then
          vim.diagnostic.enable(false)
          vim.g.diagnostics_enabled = false
          print("Diagnostics OFF")
        else
          vim.diagnostic.enable(true)
          vim.g.diagnostics_enabled = true
          print("Diagnostics ON")
        end
      end)

      -- Diagnostics config
      vim.diagnostic.config({
        virtual_text = true,
        underline = false,
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
      })
    end,
  },
}
