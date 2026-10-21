-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

-- Relative line number
-- vim.wo.number = true
-- vim.wo.relativenumber = true
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.statuscolumn = "%s %l %r"

-- Other settings
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.cmd("language C.UTF-8")

-- Folding
vim.opt.foldenable = true

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.opt.foldmethod = "indent"

-- Automatically yank text to the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Diagnostic
vim.diagnostic.config({
  virtual_text = false, -- Turn off standard single-line virtual text
  virtual_lines = true, -- Turn off virtual_lines to prevent screen overflow
  float = {
    scope = 'line',     -- Show errors for the current line
    border = 'rounded', -- Rounded border for the float window
    focusable = true,   -- Allows pressing <C-w>p to jump into the float
    max_width = 100,    -- Keeps the popup width compact so text wraps
  },
})

vim.opt.updatetime = 250
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    -- Only open if there are diagnostics on the current line
    local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
    if #diagnostics > 0 then
      vim.diagnostic.open_float(nil, { focus = false })
    end
  end,
})
