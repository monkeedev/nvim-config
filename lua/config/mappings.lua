-- Create tab
vim.keymap.set('n', '<C-t>', ':tabnew<CR>');

-- Tab navigation
vim.keymap.set('n', '<C-h>', ':tabp<CR>');
vim.keymap.set('n', '<C-l>', ':tabn<CR>');

vim.keymap.set('n', '<leader>v', ':vsplit<CR>');
vim.keymap.set('n', '<leader>s', ':split<CR>');
vim.keymap.set('n', '<C-j>', ':botright 10split<CR>:terminal<CR>');
vim.keymap.set('n', '<C-c>', ':hide<CR>');
vim.keymap.set('n', '<Esc>', ':nohl<CR>');
vim.keymap.set('n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', { desc = "Go to Definition", silent = true, noremap = true })
-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to Declaration", silent = true, noremap = true })
-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Go to Reference" })

-- Exit terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
    return hover({
        max_width = 100,
        max_height = 14,
        border = 'rounded',
    })
end
