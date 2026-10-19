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
  virtual_text = false,
  virtual_lines = true,
})


