return {
  -- TODO comments
  { 
    'folke/todo-comments.nvim', 
    dependencies = { 
      'nvim-lua/plenary.nvim' 
    }, 
    opts = { 
      signs = false 
    }
  },
  -- Cool line
  { 
    'nvim-lualine/lualine.nvim', 
    dependencies = { 
      'nvim-tree/nvim-web-devicons' 
    },
  },
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
	{
		"brenoprata10/nvim-highlight-colors",
		ft = { "css" },
		config = true,
		lazy = true,
	}
}
