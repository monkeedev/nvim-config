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

-- Exit terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return hover({
    max_width = 100,
    max_height = 14,
    border = 'rounded',
  })
end

-- Custom smart Go-to-Definition function with tab reuse
local function smart_goto_definition()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, _, _)
    if err or not result or vim.tbl_isempty(result) then
      return -- Do nothing if the reference/definition is missing
    end

    -- Handle single location, list of locations, or LocationLinks
    local target = vim.islist(result) and result[1] or result
    local uri = target.targetUri or target.uri
    if not uri then return end

    local current_uri = vim.uri_from_bufnr(0)

    -- If it's in the same file, stay in the current window/tab
    if uri == current_uri then
      -- vim.lsp.util.jump_to_location(target, "utf-8")
      vim.lsp.util.show_document(target, "utf-8", { focus = true })
      return
    end

    -- Check if the target file is already open in any existing tab/window
    local found_tab = nil
    local found_win = nil

    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
        local bufnr = vim.api.nvim_win_get_buf(win)
        if vim.uri_from_bufnr(bufnr) == uri then
          found_tab = tab
          found_win = win
          break
        end
      end
      if found_tab then break end
    end

    -- Switch to the existing tab/window if found, otherwise open a new tab
    if found_tab and found_win then
      vim.api.nvim_set_current_tabpage(found_tab)
      vim.api.nvim_set_current_win(found_win)
    else
      vim.cmd('tabnew')
    end

    -- Jump to the target location
    -- vim.lsp.util.jump_to_location(target, "utf-8")
    vim.lsp.util.show_document(target, "utf-8", { focus = true })
  end)
end


-- Bind it using LspAttach so it overrides LazyVim's defaults correctly
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    vim.keymap.set('n', 'gd', smart_goto_definition, {
      buffer = event.buf,
      desc = "Smart Go to Definition (Reuse Tab)",
      silent = true,
      noremap = true
    })
  end,
})

vim.keymap.set('n', '<leader>rw', vim.lsp.buf.rename, { desc = 'LSP rename variable' })

--
-- vim.keymap.set(
--   'n',
--   '<leader>rw',
--   ":%s/\\<<C-r>=expand('<cword>')<CR>\\>/<C-r>=expand('<cword>')<CR>/g<Left><Left>",
--   { desc = 'Rename word under cursor in file' }
-- )
