-- Neovide
-- vim.g.neovide_refresh_rate_idle = 5 -- This might not have an effect on every platform (e.g. Wayland).
vim.g.neovide_fullscreen = false
vim.g.neovide_hide_mouse_when_typing = false
vim.g.neovide_refresh_rate = 165
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_vfx_particle_lifetime = 5.0
vim.g.neovide_cursor_vfx_particle_density = 14.0
vim.g.neovide_cursor_vfx_particle_speed = 12.0
-- vim.o.guifont = "CaskaydiaCove Nerd Font:h13:b"
vim.o.guifont = "Maple Mono NF:h14:b"
-- vim.o.guifont = "JetBrainsMono Nerd Font:h12:b"
-- vim.o.guifont = "FiraCode Nerd Font:h15:b"
-- vim.o.guifont = "SF Mono:h16:b"
-- vim.o.guifont = "BlexMono Nerd Font Mono:h16:b"

-- vim options
vim.opt.shiftwidth = 0
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.timeoutlen = 10
-- vim.opt.guicursor = "n:ver100" --  set cursor of normal mode as beam, change the number to select the width of the cursor.
vim.opt.guicursor = "a:block" --  set cursor of normal mode as block for all modes.
vim.opt.ruler = true -- show line,col at the cursor pos
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true -- show a line where the current cursor is
vim.opt.signcolumn = "yes" -- show sign column as first column
vim.opt.wrap = true -- wrap long lines
vim.opt.breakindent = true -- start wrapped lines indented
vim.opt.linebreak = true -- do not break words on line wrap
vim.opt.undofile = true -- unlimited undos

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	-- pattern = "*.lua",
	timeout = 1000,
}
lvim.builtin.telescope.defaults.path_display = { shorten = 5 }
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.colorscheme = "oxocarbon"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.lualine.style = "lvim"
lvim.builtin.terminal.open_mapping = "<C-t>"

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.ignore_install = { "haskell" }

-- lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.automatic_configuration.skipped_servers = {
	"nil",
	"nil_ls",
	"pyre",
	"jedi_language_server",
	"pylsp",
	"ruff_lsp",
	"sourcery",
	"cssmodules_ls",
	"denols",
	"ember",
	"eslint",
	"glint",
	"quick_lint_js",
	"rome",
	"stylelint_lsp",
	"vtsls",
}

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-8" }

-- Enable LSP
require("lspconfig").clojure_lsp.setup({
	command = "/home/redyf/.nix-profile/bin/clojure-lsp",
	filetypes = { "clojure", "edn" },
})
require("lspconfig").elixirls.setup({
	cmd = { "/home/redyf/elixir/elixir_sh/language_server.sh" },
	filetypes = { "elixir", "eelixir", "heex", "surface" },
})

require("lspconfig").rnix.setup({
	command = "rnix-lsp",
	filetypes = { "nix" },
})

require("lspconfig").clangd.setup({
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
})

require("lspconfig").dartls.setup({})

-- require("flutter-tools").setup({}) -- use defaults

-- local lspconfig = require("lspconfig")
-- lspconfig.ccls.setup({
-- 	init_options = {
-- 		compilationDatabaseDirectory = "build",
-- 		index = {
-- 			threads = 0,
-- 		},
-- 		clang = {
-- 			excludeArgs = { "-frounding-math" },
-- 		},
-- 	},
-- })

-- require("lspconfig").ccls.setup({
-- 	cmd = { "ccls" },
-- 	filetypes = { "c", "cpp", "objc", "objcpp" },
-- })

-- Linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		command = "flake8",
		filetypes = { "python" },
		extra_args = { "--ignore", "E501, E275, F841" },
	},
	{ command = "shellcheck", args = { "--severity", "warning" } }, -- {
	--   command = "codespell",
	--   filetypes = { "javascript", "python" },
	-- },
	{
		command = "clj_kondo",
		filetypes = { "clojure" },
		-- extra_args = {"--ignore", "112, 631"}
	},
	{ command = "selene", filetypes = { "lua" } },
	{ command = "statix", filetypes = { "nix" } },
	-- { command = "cpplint", filetypes = { "c", "cpp", "objc", "objcpp" }, offsetEncoding = "utf-8" },
})

-- Formatters
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "zprint", filetypes = { "clojure" } },
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "black", filetypes = { "python" } },
	{
		command = "prettier",
		extra_args = { "--print-width", "100" },
		filetypes = { "typescript", "typescriptreact" },
	},
	{ command = "alejandra", filetypes = { "nix" } },
	-- { command = "astyle", filetypes = { "c", "cpp", "objc", "objcpp" }, offsetEncoding = "utf-8" },
	{ command = "dart_format", filetypes = { "dart" } },
})

-- Debuggers
local dap = require("dap")
dap.configurations.elixir = {
	{
		type = "mix_task",
		name = "mix test",
		task = "test",
		taskArgs = { "--trace" },
		request = "launch",
		startApps = true, -- for Phoenix projects
		projectDir = { "/home/redyf/elixir/" },
		requireFiles = { "test/**/test_helper.exs", "test/**/*_test.exs" },
	},
}
dap.adapters.mix_task = {
	type = "executable",
	command = "/home/redyf/elixir/elixir_sh/debugger.sh", -- debugger.bat for windows
	args = {},
}

local dap = require("dap")

dap.adapters.dart = {
	type = "executable",
	command = "dart",
	-- This command was introduced upstream in https://github.com/dart-lang/sdk/commit/b68ccc9a
	args = { "debug_adapter" },
}
dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch Dart Program",
		-- The nvim-dap plugin populates this variable with the filename of the current buffer
		program = "${file}",
		-- The nvim-dap plugin populates this variable with the editor's current working directory
		cwd = "${workspaceFolder}",
		args = { "--help" }, -- Note for Dart apps this is args, for Flutter apps toolArgs
	},
}

local dap = require("dap")
dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "/home/redyf/.nix-profile/bin/python"
			end
		end,
	},
}
dap.adapters.python = {
	type = "executable",
	command = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python",
	args = { "-m", "debugpy.adapter" },
}

lvim.plugins = {
	-- Themes
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "decaycs/decay.nvim", name = "decay" },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "tiagovla/tokyodark.nvim", lazy = true },
	-- Dap
	{ "mfussenegger/nvim-dap-python" },
	-- Other tools
	{ "nvim-neorg/neorg", lazy = true },
	{ "norcalli/nvim-colorizer.lua" },
	{ "andweeb/presence.nvim" },
	{ "sindrets/diffview.nvim", event = "BufRead" },
	{ "Olical/conjure" },
	{ "Olical/aniseed" },
	{ "tpope/vim-dispatch" },
	{ "clojure-vim/vim-jack-in" },
	{ "radenling/vim-dispatch-neovim" },
	-- {
	-- 	"akinsho/flutter-tools.nvim",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"stevearc/dressing.nvim", -- optional for vim.ui.select
	-- 	},
	-- },
	--
	-- Fun
	{ "ThePrimeagen/vim-be-good", lazy = true },
}

-- Neorg plugin for notes
require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.dirman"] = {
			config = {
				workspaces = { work = "~/notes/work", home = "~/notes/home" },
			},
		},
	},
})

-- Discord Presence plugin
require("presence"):setup({
	file_assets = {
		c = { "C ", "https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/c.png" },
		cpp = {
			"C++",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/cpp.png",
		},
		rust = {
			"Rust",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/rust.png",
		},
		html = {
			"HTML",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/html.png",
		},
		css = {
			"CSS",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/css.png",
		},
		scss = {
			"Sass",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/scss.png",
		},
		["tailwind.config.js"] = {
			"Tailwind",
			"https://avatars.githubusercontent.com/u/70907734?v=4",
		},
		js = {
			"JavaScript",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/js.png",
		},
		ts = {
			"TypeScript",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/ts.png",
		},
		jsx = {
			"React",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/jsx.png",
		},
		tsx = {
			"React",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/tsx.png",
		},
		npm = {
			"NPM",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/npm.png",
		},
		debugging = {
			"Debugging",
			"https://github.com/leonardssh/vscord/blob/main/assets/icons/debugging.png?raw=true",
		},
		docker = {
			"Docker",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/docker.png",
		},
		cl = { "Common Lisp", "lisp" },
		clj = {
			"Clojure",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/clojure.png",
		},
		cljs = { "ClojureScript", "clojurescript" },
		ex = {
			"Elixir",
			"https://github.com/leonardssh/vscord/blob/main/assets/icons/elixir.png",
		},
		exs = {
			"Elixir",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/elixir.png",
		},
		go = {
			"Go",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/go.png",
		},
		lua = {
			"Lua",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/lua.png",
		},
		py = {
			"Python",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/python.png",
		},
		yaml = { "YAML", "https://avatars.githubusercontent.com/u/70907734?v=4" },
		nix = {
			"Nix",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/nix.png",
		},
		md = {
			"Markdown",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/markdown.png",
		},
		["zshrc"] = {
			"zsh",
			"https://avatars.githubusercontent.com/u/70907734?v=4",
		},
		json = { "JSON", "https://avatars.githubusercontent.com/u/70907734?v=4" },
		conf = {
			"configuration file",
			"https://avatars.githubusercontent.com/u/70907734?v=4",
		},
		config = {
			"Configuration file",
			"https://avatars.githubusercontent.com/u/70907734?v=4",
		},
		sql = {
			"SQL",
			"https://raw.githubusercontent.com/leonardssh/vscord/main/assets/icons/sql.png",
		},
		shell = {
			"Shell",
			"https://avatars.githubusercontent.com/u/70907734?v=4",
		},
	},
	auto_update = true,
	neovim_image_text = "LunarVim",
	-- main_image = "https://static-00.iconduck.com/assets.00/apps-neovim-icon-512x512-w4ecv3uh.png",
	-- main_image = "https://camo.githubusercontent.com/7ef2897c4de6940f119595f50119a887b538d42d4a0b65a15bd0148e2b6bec5b/68747470733a2f2f692e696d6775722e636f6d2f654e62643975442e706e67",
	main_image = "file",
	log_level = nil,
	client_id = "793271441293967371",
	show_time = true,
	workspace_text = function()
		return "I C you :skull:"
	end,
})

-- Nvim-Colorizer Plugin
require("colorizer").setup()

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
