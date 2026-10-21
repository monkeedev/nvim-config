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

      require('luasnip.loaders.from_snipmate').load({ paths = "./snippets" })
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
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        if col == 0 then return false end
        local line_text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        -- Check if the character right before the cursor is NOT whitespace
        return line_text:sub(col, col):match("%s") == nil
      end

      local cmp = require('cmp')
      local luasnip = require('luasnip')

      local opts = {
        sources = cmp.config.sources {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750, option = { show_autosnippets = true } },
          { name = "path",     priority = 250 },
        },
        -- Add the window configuration here for framed borders
        -- Explicitly define border characters and highlights
        window = {
          completion = cmp.config.window.bordered({
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(original)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif vim.snippet.active({ direction = 1 }) then
              -- Jump forward in snippets if active
              vim.snippet.jump(1)
            elseif has_words_before() then
              -- If we are typing right after characters (like 'arr.'), trigger completion
              cmp.complete()
            else
              original()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(original)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.jump(-1)
            else
              original()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          format = function(entry, vim_item)
            -- Optional: Limit the length of completion item labels to keep the menu clean
            vim_item.abbr = string.sub(vim_item.abbr, 1, 40)
            return vim_item
          end
        },
        experimental = {
          ghost_text = true
        }
      }
      cmp.setup(opts)
    end,
  },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-path",     lazy = true },
  { "hrsh7th/cmp-buffer",   lazy = true },

}
