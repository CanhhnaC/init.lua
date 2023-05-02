local default_plugins = {
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "tpope/vim-surround",

  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup()
      vim.cmd "colorscheme tokyonight"
    end,
  },

  {
    "NvChad/nvterm",
    lazy = true,
    config = function()
      require("nvterm").setup()
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "plugins.configs.nvimtree"
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      vim.g.nvimtree_side = opts.view.side
    end,
  },

  {
    "phaazon/hop.nvim",
    lazy = true,
    branch = "v2", -- optional but strongly recommended
    cmd = { "HopChar1", "HopPattern" },
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "plugins.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", lazy = true },
  { "nvim-treesitter/playground", lazy = true },

  -- Lsp stuff
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        config = function()
          require("copilot").setup {
            suggestion = { enabled = false },
            panel = { enabled = false },
          }
        end,
      },
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        sources = {
          { name = "copilot" },
          { name = "nvim_lsp" },
        },
        mapping = {
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
        },
      }
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "plugins.configs.null-ls"
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    tag = "release",
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = function()
      return require("plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return require "plugins.configs.telescope"
    end,

    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    "sudormrfbin/cheatsheet.nvim",
    lazy = true,
    cmd = { "Cheatsheet" },
    config = function()
      require("cheatsheet").setup {
        bundled_cheatsheets = {
          enabled = {
            "default",
          },
        },
        bundled_plugin_cheatsheets = {
          enabled = {
            "gitsigns.nvim",
            "telescope.nvim",
          },
        },
      }
    end,
  },

  {
    "numToStr/Comment.nvim",
    lazy = true,
    keys = { "gcc", "gbc" },
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble", "TroubleClose ", "TroubleToggle" },
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },

  {},
}

local config = require "plugins.configs.lazy_nvim"

require("lazy").setup(default_plugins, config)
