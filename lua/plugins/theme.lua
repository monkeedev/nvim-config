return {
  -- { 
  --   'catppuccin/nvim', 
  --   name = "catppuccin", 
  --   lazy = false, 
  --   priority = 1000, 
  --   opts = {
  --     transparent_background = true
  --   }
  -- },
  --
  {
    "tiagovla/tokyodark.nvim",
    opts = {
        -- custom options here
        custom_highlights = {
          CursorLine = { bg = "#414378" },
          Visual = { bg = "#414378" },
        }
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        vim.cmd [[colorscheme tokyodark]]
    end,
  }
}
