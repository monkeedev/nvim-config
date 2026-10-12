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
-- vim.keymap.set('n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', { desc = "Go to Definition", silent = true, noremap = true })
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

-- Custom smart Go-to-Definition function
local function smart_goto_definition()
  local params = vim.lsp.util.make_position_params()
  
  vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, _, _)
    if err or not result or vim.tbl_isempty(result) then
      return -- Do nothing if the reference/definition is missing
    end

    -- Handle single location, list of locations, or LocationLinks
    local target = vim.tbl_islist(result) and result[1] or result
    local uri = target.targetUri or target.uri
    if not uri then return end

    local current_uri = vim.uri_from_bufnr(0)

    if uri ~= current_uri then
      vim.cmd('tabnew')
    end

    -- Jump to the target location
    vim.lsp.util.jump_to_location(target, "utf-8")
  end)
end

-- Bind it using LspAttach so it overrides LazyVim's defaults correctly
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    vim.keymap.set('n', 'gd', smart_goto_definition, { 
      buffer = event.buf, 
      desc = "Smart Go to Definition/Reference", 
      silent = true, 
      noremap = true 
    })
  end,
})
