--[[
lvim is the global options object
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 5000
lvim.colorscheme = "oxocarbon"
vim.opt.timeoutlen = 10
-- vim.opt.guicursor = 'a:ver10' --  set cursor of normal mode as beam.
vim.opt.guicursor = 'a:block' --  set cursor of normal mode as block.
vim.opt.ruler = true  -- show line,col at the cursor pos
vim.opt.relativenumber    = true
vim.opt.number            = true
vim.opt.cursorline        = true      -- Show a line where the current cursor is
vim.opt.signcolumn        = 'yes'     -- Show sign column as first column
vim.opt.wrap              = true      -- wrap long lines
vim.opt.breakindent       = true      -- start wrapped lines indented
vim.opt.linebreak         = true      -- do not break words on line wrap

    -- local dap = require('dap')
    -- dap.configurations.python = {
    --   {
    --     type = 'python';
    --     request = 'launch';
    --     name = "Launch file";
    --     program = "${file}";
    --     pythonPath = function()
    --       -- return '/usr/bin/python'
    --       return '~/.nix-profile/bin/python'
    --     end;
    --   },
    -- }

local dap = require('dap')
  dap.adapters.python = {
    type = 'executable';
    command = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python';
    args = { '-m', 'debugpy.adapter' };
  }

-- local dap = require('dap')
-- dap.adapters.python = {
--   type = 'executable';
--   command = '~/.virtualenvs/debugpy/bin/python';
--   args = { '-m', 'debugpy.adapter' };
-- }

local dap = require('dap')
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        -- return '/usr/bin/python'
        return '/home/redyf/.nix-profile/bin/python'
      end
    end;
  },
}

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- Neovide
vim.o.guifont = "CaskaydiaCove Nerd Font:h13:b"
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_refresh_rate = 165
vim.g.neovide_cursor_vfx_mode = "railgun"
-- vim.g.neovide_refresh_rate_idle = 5 -- This might not have an effect on every platform (e.g. Wayland). 
-- vim.g.neovide_fullscreen = false 

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "nix"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
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

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
 local formatters = require "lvim.lsp.null-ls.formatters"
 formatters.setup {
   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
  -- {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    -- command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    -- extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    -- filetypes = { "typescript", "typescriptreact" },
  -- },
 }

-- -- set additional linters
 local linters = require "lvim.lsp.null-ls.linters"
 linters.setup {
   { command = "flake8", filetypes = { "python" }, extra_args = { "--ignore", "E501, E275, F841" } },
  {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    -- extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
 }

-- Additional Plugins
 lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--      cmd = "TroubleToggle",
--     },
  --
  --    {
  --     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --     config = function()
  --       require("lsp_lines").setup()
  --   end,
  -- },

      "norcalli/nvim-colorizer.lua",

      "andweeb/presence.nvim",

    { "catppuccin/nvim", as = "catppuccin" },

    { "nyoom-engineering/oxocarbon.nvim"  },
      'mfussenegger/nvim-dap-python'
}

require("presence"):setup ({
    file_assets = {
        html = { "HTML", "https://icon-library.com/images/html5-icon/html5-icon-13.jpg" },
        css = { "CSS", "https://logospng.org/download/css-3/logo-css-3-2048.png" },
        scss = { "Sass", "https://avatars.githubusercontent.com/u/70907734?v=4" },
        tailwind = { "Tailwind", "https://avatars.githubusercontent.com/u/70907734?v=4" },
        js = { "JavaScript", "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Unofficial_JavaScript_logo_2.svg/2048px-Unofficial_JavaScript_logo_2.svg.png" },
        jsx = { "React", "https://cdn.kinandcarta.com/-/media-assets/images/kincarta/insights/2022/02/react-native/react_hero.png?as=0&iar=0&w=992&rev=61e1dad3af7e465e9544cf8490237772&extension=webp&hash=02C6CCE2CDDAD0216D16A5E26835691F" },
        tsx = { "React", "https://cdn.kinandcarta.com/-/media-assets/images/kincarta/insights/2022/02/react-native/react_hero.png?as=0&iar=0&w=992&rev=61e1dad3af7e465e9544cf8490237772&extension=webp&hash=02C6CCE2CDDAD0216D16A5E26835691F" },
        go = { "Go", "https://avatars.githubusercontent.com/u/70907734?v=4" },
        lua = { "Lua", "https://blog.oat.zone/content/images/2022/04/lua.png" },
        py = { "Python", "https://ih1.redbubble.net/image.1065285617.2173/flat,750x,075,f-pad,750x1000,f8f8f8.u1.jpg" },
        yaml = { "YAML", "https://avatars.githubusercontent.com/u/70907734?v=4" },
        nix = { "Nix", "https://camo.githubusercontent.com/8c73ac68e6db84a5c58eef328946ba571a92829b3baaa155b7ca5b3521388cc9/68747470733a2f2f692e696d6775722e636f6d2f367146436c41312e706e67" },
        md = { "Markdown", "https://avatars.githubusercontent.com/u/70907734?v=4" },
        zsh = { "shell", "https://avatars.githubusercontent.com/u/70907734?v=4" },
        json = { "JSON", "https://avatars.githubusercontent.com/u/70907734?v=4" },
        conf = { "Configuration file", "https://avatars.githubusercontent.com/u/70907734?v=4" },
        config = { "Configuration file", "https://avatars.githubusercontent.com/u/70907734?v=4" },
        sql = { "SQL", "https://avatars.githubusercontent.com/u/70907734?v=4" },
    },
        auto_update = true,
        neovim_image_text = "LunarVim",
        -- main_image = "https://static-00.iconduck.com/assets.00/apps-neovim-icon-512x512-w4ecv3uh.png",
        main_image = "file",
        log_level = nil,
        client_id = "793271441293967371",
        show_time = true,
        workspace_text = function()
            return "ssssssss"
        end,
})
    -- } 

-- LSP Lines plugin (keybind = gj)
-- Disable virtual text
-- lvim.lsp.diagnostics.virtual_text = false
-- lvim.builtin.which_key.mappings["gj"] = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle LSP lines" }

-- Nvim-Colorizer Plugin
  require 'colorizer'.setup()

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
