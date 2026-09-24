return {
  {
    'L3MON4D3/LuaSnip',
    lazy = false,
    dependencies = {
      { "rafamadriz/friendly-snippets" },
    },
    config = function(opts)
      local ls = require('luasnip')
      ls.setup(opts)

      require('luasnip.loaders.from_snipmate').load({ paths = "./snippets"})
      require("luasnip.loaders.from_vscode").lazy_load()

      ls.filetype_extend("typescript", { "javascript" })
      ls.filetype_extend("typescriptreact", { "javascript", "typescript" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local opts = {
        sources = cmp.config.sources {
          { name = "nvim_lsp", },
          { name = "path", },
          { name = "buffer", },
          { name = "luasnip", option = { show_autosnippets = true } }
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<tab>"] = cmp.mapping(function(original)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              print("fallback")
              original()
            end
          end, {"i", "s"}),
          ["<S-tab>"] = cmp.mapping(function(original)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.jump(-1)
            else
              original()
            end
          end, {"i", "s"}),
        }),
        experimental = {
          ghost_text = true
        }
      }
      cmp.setup(opts)
    end,
  },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },

}
