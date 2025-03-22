return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    local light_themes = {
      ["Tokyonight Day"] = "tokyonight-day",
      ["Catppuccin Latte"] = "catppuccin-latte",
      ["Kanagawa Lotus"] = "kanagawa-lotus",
      ["Dayfox"] = "dayfox",
      ["Dawnfox"] = "dawnfox",
      ["RosePine Dawn"] = "rose-pine-dawn",
      ['Cyberdream Light'] = "cyberdream",
      ['Bluloco Light'] = "bluloco-light",
    }
    local dark_themes = {
      ["Tokyonight Moon"] = "tokyonight-moon",
      ["Tokyonight Night"] = "tokyonight-night",
      ["Tokyonight Storm"] = "tokyonight-storm",
      ["Catppuccin Macchiato"] = "catppuccin-macchiato",
      ["Catppuccin Frappe"] = "catppuccin-frappe",
      ["Catppuccin Mocha"] = "catppuccin-mocha",
      ["Kanagawa Dragon"] = "kanagawa-dragon",
      ["Kanagawa Wave"] = "kanagawa-wave",
      ["Nightfox"] = "nightfox",
      ["Duskfox"] = "duskfox",
      ["Nordfox"] = "nordfox",
      ["Terafox"] = "terafox",
      ["Carbonfox"] = "carbonfox",
      ["RosePine"] = "rose-pine-main",
      ["RosePine Moon"] = "rose-pine-moon",
      ["Oxocarbon"] = "oxocarbon",
      ["Moonfly"] = "moonfly",
      ['CyberDream'] = "cyberdream",
      ["Nightfly"] = "nightfly",
      ["Nordic"] = "nordic",
      ["Melange"] = "melange",
      ["Gruvbox Baby"] = "gruvbox-baby",
      ["Bluloco Dark"] = "bluloco-dark",
      ["Vague"] = "vague",
      ["Everforest"] = "everforest",
      ["NightOwl"] = "night-owl",
    }

    local onedark = {
      {
        name = "OneDark",
        colorscheme = "onedark",
        before = [[
      vim.opt.background = "dark"
      require('onedark').setup({style = 'dark'})
      require('onedark').load()
    ]],
      },
      {
        name = "OneDark Darker",
        colorscheme = "onedark",
        before = [[
      vim.opt.background = "dark"
      require('onedark').setup({style = 'darker'})
      require('onedark').load()
    ]],
      },
      {
        name = "OneDark Cool",
        colorscheme = "onedark",
        before = [[
      vim.opt.background = "dark"
      require('onedark').setup({style = 'cool'})
      require('onedark').load()
    ]],
      },
      {
        name = "OneDark Deep",
        colorscheme = "onedark",
        before = [[
      vim.opt.background = "dark"
      require('onedark').setup({style = 'deep'})
      require('onedark').load()
    ]],
      },
      {
        name = "OneDark Warm",
        colorscheme = "onedark",
        before = [[
      vim.opt.background = "dark"
      require('onedark').setup({style = 'warm'})
      require('onedark').load()
    ]],
      },
      {
        name = "OneDark Warmer",
        colorscheme = "onedark",
        before = [[
      vim.opt.background = "dark"
      require('onedark').setup({style = 'warmer'})
      require('onedark').load()
    ]],
      },
    }
    local theme_list = {}
    for k, v in pairs(light_themes) do
      table.insert(theme_list, { name = k, colorscheme = v, before = [[vim.opt.background = "light"]] })
    end
    for k, v in pairs(dark_themes) do
      table.insert(theme_list, { name = k, colorscheme = v, before = [[vim.opt.background = "dark"]] })
    end
    for i, v in ipairs(onedark) do
      table.insert(theme_list, v)
    end

    require("themery").setup({
      themes = theme_list,
      livePreview = true,
    })
  end
}
