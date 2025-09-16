-- This is your main space for LSP configuration. It is split into 3 main plugins. First one is "mason" which is the main server side plugin for LSPs, "nvim-lspconfig" is the one that sends requests to the server ("mason") and "mason-lspconfig" is the one that connects them (that is where you are gonna isntall the LSPs)
-- Mason pretty much puts the packages into your PATH
-- HOW TO DOWNLOAD THE LSP:
-- First of all, choose which one you want for your language, you can google some or check the ":Mason" for available ones
-- Then you can install it from ":Mason" page or you can add it to "ensure_installed" list then reload
-- Then go to the "capabilities" portion and then add the "lspconfig" in the same format as the already written ones
-- Result of this configuration are the vim.lsp.buf functions that we are gonna override later
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      automatic_enable = true,
      -- This is good to have but since some people don't have some packages needed to download this, it leads to constant start up error messages
      -- ensure_installed = { "clangd", "lua_ls", "ts_ls", "html", "solargraph", "rust_analyzer", "gopls"},
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities() -- Connecting your LSP to your completions

      -- This is the format to inputing your own LSP server's completions you install
      local lspconfig = require("lspconfig")
      lspconfig.ts_ls.setup({ -- TS but also JS
        capabilities = capabilities
      })
      lspconfig.clangd.setup({ -- C & C++
        capabilities = capabilities
      })
      lspconfig.solargraph.setup({ -- Ruby
        capabilities = capabilities
      })
      lspconfig.html.setup({ -- Guess
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({ -- Lua
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },      -- Neovim uses LuaJIT
            diagnostics = { globals = { "vim" } }, -- tell LSP that 'vim' is global
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
      lspconfig.rust_analyzer.setup({ -- Guess again
        capabilities = capabilities
      })
      lspconfig.gopls.setup({ -- Go
        capabilities = capabilities
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})                -- It gives you the definition of the current piece of code you are hovering over
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})  -- Jumps to the definition of current piece of code (function, variable...)
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})  -- Showcases all the references in the code and pulls up a prompt
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {}) -- Shows the code actions on current line
      -- Go to next diagnostic, the float shows the diagnostic when scrolling, honestly it distracts me it's really not needed
      vim.keymap.set("n", "<leader>ge", function() vim.diagnostic.jump({ count = 1, float = false }) end,
        { desc = "Go to next diagnostic" })
      -- Go to previous diagnostic, btw <Leader>ge and <Leader>gE as in "Get Error"
      vim.keymap.set("n", "<leader>gE", function() vim.diagnostic.jump({ count = -1, float = false }) end,
        { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "<Leader>fm", vim.lsp.buf.format, { desc = "Format the file" }) -- This is for formatting the file using LSP or "Fake LSP" used by none-ls
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable under cursor" }) -- This is the best renamer you can have



      -- THIS IS DEPRECATED AND WILL BE REMOVED IN THE NVIM 0.12 UPDATE
      -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      -- for type, icon in pairs(signs) do
      --   local hl = "DiagnosticSign" .. type
      --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      -- end

      -- THIS IS THE NEW METHOD
      vim.diagnostic.config({
        virtual_text = true,      -- Linting (that little inline text that explains your diagnostic)
        underline = false,        -- ugly af
        update_in_insert = false, -- You want the error to show only when you are done typing otherwise it's so fucking ugly and distracting
        severity_sort = true,     -- Error is always more important that warnings
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
          -- optional: also highlight line numbers, I don't like it
          -- numhl = {
          --   [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
          --   [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
          --   [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
          --   [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
          -- },
        },
      })
    end,
  },
}
