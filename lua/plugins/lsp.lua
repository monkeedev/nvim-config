return {
  {
    "neovim/nvim-lspconfig",
    -- opts = function(_, opts)
    --   opts.reuse_win = true
    --   -- local lsp = extra.name or "vtsls"
    --   -- local servers = { "tsserver", "ts_ls", "vtsls", "tsgo" }
    --   -- for _, server in ipairs(servers) do
    --   --   opts.servers[server] = opts.servers[server] or {}
    --   --   opts.servers[server].enabled = server == lsp
    --   -- end
    -- end,
  },
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
  }
}
