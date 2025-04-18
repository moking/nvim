return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		config = function() require("config.tokyonight") end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		config = function() require("config.kanagawa") end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		config = function() require("config.catppuccin") end,
	},

	{ "rcarriga/nvim-notify", },

	{
		"neovim/nvim-lspconfig",
		cmd = "Mason",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function() require("config.lsp") end,
	},

	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
		},
		config = function() require("config.telescope") end,
	},

	{
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		keys = {
			{ "tt", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		},
		dependencies = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = function() require("config.nvim-tree") end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function() require("config.lualine") end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function() require("config.treesitter") end,
	},

	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			{ "onsails/lspkind-nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function() require("config.cmp") end,
	},

	{
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "ts", "<cmd>Outline<CR>", desc = "Toggle Symbol Outline" },
		},
		opts = {
			symbols = { icon_source = lspkind, },
		}
	},

	{
		"akinsho/nvim-toggleterm.lua",
		cmd = { "ToggleTerm" },
		keys = {
			{ "<C-n>", "<cmd>ToggleTerm<CR>", desc = "Toggle Term" },
		},
		opts = {
			direction = "float",
		},
	},

	{ "ironhouzi/starlite-nvim" },

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function() require("config.which") end,
	},

	{
		"yorickpeterse/nvim-window",
		keys = {
			{ "<leader>w", "<cmd>lua require('nvim-window').pick()<CR>", desc = "nvim-window Selection" },
		},
		config = function() require("config.nvim-window") end,
 	},

	{ "tpope/vim-unimpaired" },
	{
		"tpope/vim-fugitive",
		config = function() require("config.fugitive") end,
	},

	{
		"natecraddock/workspaces.nvim",
		config = function() require("config.workspaces") end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				names = false,
				mode = "background",
			},
		},
	},

	{
		"echasnovski/mini.indentscope",
		version = false,
		config = function() require("config.mini-indentscope") end,
	},

	{
		"x56Jason/glance.nvim",
		opts = {
			patchdiff = "diffonly",
			q_quit_log = "off",
		},
	},

	{
		"x56Jason/gitee.nvim",
		dependencies = { "x56Jason/glance.nvim" },
		opts = {
			token_file = "~/.token.gitee",
			repo = "openeuler/kernel",
		},
	},

	{
		"diepm/vim-rest-console",
		config = function() require("config.vim-rest-console") end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		config = function() require("config.harpoon") end,
	},

	{
		"j-hui/fidget.nvim",
		config = true,
	},
	{ "tpope/vim-sleuth" },
	{"airblade/vim-gitgutter"},
        {"rafi/awesome-vim-colorschemes"},
	{"vimwiki/vimwiki", 
		init = function() 
			vim.g.vimwiki_list = {
				{
					path = '~/vimwiki/src/',
					syntax = 'markdown',
                                        ext = '.md',
					path_html = '~/vimwiki/html/',
				},
			}
		end,
	},
        {"gelguy/wilder.nvim"},
	{"lewis6991/gitsigns.nvim"},
	{"hrsh7th/cmp-path"},
	-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		}
	},
	{ 'echasnovski/mini.align', version = '*' },
	{"simrat39/symbols-outline.nvim"},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"sindrets/diffview.nvim",        -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			--"ibhagwan/fzf-lua",              -- optional
			--"echasnovski/mini.pick",         -- optional
		},
	},
	{"ervandew/supertab"},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{"mvllow/modes.nvim"},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "echasnovski/mini.icons" },
		opts = {}
	},
	{"voldikss/vim-floaterm"},
}

