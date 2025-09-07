return {
  {
    "hrsh7th/cmp-nvim-lsp", -- This one communicates with your LSP server
  },
  {
    "hrsh7th/cmp-nvim-lua", -- Useful for completions when doing nvim configs
    dependencies = { "nvim-cmp" }
  },
  {
    "hrsh7th/cmp-path",  -- For path suggestion
    dependencies = { "nvim-cmp" }
  },
  {
    "L3MON4D3/LuaSnip", -- Main snippets handler
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets", -- List of snippets
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- I like cycling through the completions with TAB and S-TAB
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- This checks if a snippet can be jumped to or expanded first, so switching placeholders takes place over switching snippets
            if luasnip.jumpable() then -- It must not be expand_or_jump because it messes up SOME snippets, also it's currently 5:18 AM bruh
              luasnip.jump(1) -- 1 is very important
            -- This then checks if a completion menu is visible
            elseif cmp.visible() then
              cmp.select_next_item()
            -- This is the final check for autocompletion
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then -- Same thing here, jumping the placeholders is the top priority
              luasnip.jump(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- This is where you load your autocompletions
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "spell" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
