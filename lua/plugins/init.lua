local default_plugins = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "tpope/vim-surround",

    {
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            require("rose-pine").setup()
            vim.cmd('colorscheme rose-pine')
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
        init = function()
            require("core.utils").load_mappings "nvimtree"
        end,
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
    { 'nvim-treesitter/nvim-treesitter-context' },
    { 'nvim-treesitter/playground' },

    -- Lsp stuff
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            require('plugins.configs.lspconfig')
        end
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                "zbirenbaum/copilot.lua",
                config = function()
                    require("copilot").setup({
                        suggestion = { enabled = false },
                        panel = { enabled = false },
                    })
                end,
            },
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require('copilot_cmp').setup()
                end,
            }
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    { name = 'copilot' },
                    { name = 'nvim_lsp' },
                },
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    })
                }
            })
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("plugins.configs.null-ls")
        end,

    },

    {
        "lewis6991/gitsigns.nvim",
        tag = "release",
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
    { "sudormrfbin/cheatsheet.nvim" }

}

local config = require("plugins.configs.lazy_nvim")

require("lazy").setup(default_plugins, config)
