require("config.lazy")
require("config.mappings")

-- vim.lsp.config('ts_ls', {
--   settings = {
--     ['ts_ls'] = {}
--   }
-- })

vim.lsp.config('vtsls', {
  settings = {
    vtsls = {}
  }
})

vim.lsp.enable('vtsls')

require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require('nvim-treesitter').install { 
  'css', 
  'html', 
  'scss', 
  'swift', 
  'tsx', 
  'typescript', 
  'javascript' 
}


require('mason').setup()
require('mason-lspconfig').setup()

-- Errors
require('lualine').setup({
  sections = {
    lualine_a = {
      {
        'diagnostics',
        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
        -- or a function that returns a table as such:
        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
        sources = { 'nvim_diagnostic', 'vim_lsp', 'nvim_lsp' },

        -- Displays diagnostics for the defined severity types
        sections = { 'error', 'warn', 'info', 'hint' },

        diagnostics_color = {
          -- Same values as the general color option can be used here.
          error = 'DiagnosticError', -- Changes diagnostics' error color.
          warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
          info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
          hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
        },
        symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
        colored = true,           -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false,   -- Show diagnostics even if there are none.
      }
    }
  }
})

require("luasnip.loaders.from_vscode").load {
  exclude = { "javascript", "tsx", "typescript" }
}

-- require('ufo').setup({
--   provider_selector = function(bufnr, filetype, buftype)
--     return { 'lsp', 'indent' }
--   end
-- })
--
-- -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
