-- Neovide
-- vim.o.guifont = "CaskaydiaCove Nerd Font:h13:b"
-- vim.g.neovide_refresh_rate_idle = 5 -- This might not have an effect on every platform (e.g. Wayland). 
-- vim.g.neovide_fullscreen = false
-- vim.o.guifont = "JetBrainsMono Nerd Font:h12:b"
vim.o.guifont = "FiraCode Nerd Font:h16:b"
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_refresh_rate = 165
vim.g.neovide_cursor_vfx_mode = "railgun"

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.timeoutlen = 10
-- vim.opt.guicursor = 'a:ver10' --  set cursor of normal mode as beam.
vim.opt.guicursor = 'a:block' --  set cursor of normal mode as block for all modes.
vim.opt.ruler = true -- show line,col at the cursor pos
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true -- Show a line where the current cursor is
vim.opt.signcolumn = 'yes' -- Show sign column as first column
vim.opt.wrap = true -- wrap long lines
vim.opt.breakindent = true -- start wrapped lines indented
vim.opt.linebreak = true -- do not break words on line wrap

-- general
lvim.log.level = "info"
lvim.format_on_save = {
    enabled = true,
    -- pattern = "*.lua",
    timeout = 1000
}
lvim.builtin.telescope.defaults.path_display = {shorten = 5}
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

lvim.colorscheme = "catppuccin-macchiato"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.lualine.style = "default"
lvim.builtin.terminal.open_mapping = "<C-t>"

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.builtin.treesitter.ignore_install = {"haskell"}

-- lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.automatic_configuration.skipped_servers = {
    "nil", "nil_ls", "pyre", "jedi_language_server", "pylsp", "ruff_lsp",
    "sourcery", "cssmodules_ls", "denols", "ember", "eslint", "glint",
    "quick_lint_js", "rome", "stylelint_lsp", "vtsls"
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

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {command = "lua_format", filetypes = {"lua"}},
    {command = "black", filetypes = {"python"}}, {
        command = "prettier",
        extra_args = {"--print-width", "100"},
        filetypes = {"typescript", "typescriptreact"}
    }
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {
        command = "flake8",
        filetypes = {"python"},
        extra_args = {"--ignore", "E501, E275, F841"}
    }, {command = "shellcheck", args = {"--severity", "warning"}}, -- {
    --   command = "codespell",
    --   filetypes = { "javascript", "python" },
    -- },
    {
        command = "luacheck",
        filetypes = {"lua"},
        extra_args = {"--ignore", "112, 631"}
    }
    -- {command = "selene", filetypes = {"lua"}}
}
-- Original, teste para ver se o erro loop.lua continua (null-ls)
-- local dap = require('dap')
--   dap.adapters.python = {
--     type = 'executable';
--     command = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python';
--     args = { '-m', 'debugpy.adapter' };
--   }

local dap = require('dap')
dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = "Launch file",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
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
                return '/home/redyf/.nix-profile/bin/python'
            end
        end
    }
}
dap.adapters.python = {
    type = 'executable',
    command = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python',
    args = {'-m', 'debugpy.adapter'}
}

lvim.plugins = {

    {"catppuccin/nvim", name = "catppuccin"}, {"norcalli/nvim-colorizer.lua"},

    {"andweeb/presence.nvim"}, {"mfussenegger/nvim-dap-python"},

    {"Shadorain/shadotheme"}, {'ThePrimeagen/vim-be-good'}

}

require("presence"):setup({
    file_assets = {
        html = {
            "HTML",
            "https://icon-library.com/images/html5-icon/html5-icon-13.jpg"
        },
        css = {"CSS", "https://logospng.org/download/css-3/logo-css-3-2048.png"},
        scss = {"Sass", "https://avatars.githubusercontent.com/u/70907734?v=4"},
        tailwind = {
            "Tailwind", "https://avatars.githubusercontent.com/u/70907734?v=4"
        },
        js = {
            "JavaScript",
            "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Unofficial_JavaScript_logo_2.svg/2048px-Unofficial_JavaScript_logo_2.svg.png"
        },
        jsx = {
            "React",
            "https://cdn.kinandcarta.com/-/media-assets/images/kincarta/insights/2022/02/react-native/react_hero.png?as=0&iar=0&w=992&rev=61e1dad3af7e465e9544cf8490237772&extension=webp&hash=02C6CCE2CDDAD0216D16A5E26835691F"
        },
        tsx = {
            "React",
            "https://cdn.kinandcarta.com/-/media-assets/images/kincarta/insights/2022/02/react-native/react_hero.png?as=0&iar=0&w=992&rev=61e1dad3af7e465e9544cf8490237772&extension=webp&hash=02C6CCE2CDDAD0216D16A5E26835691F"
        },
        go = {"Go", "https://avatars.githubusercontent.com/u/70907734?v=4"},
        lua = {"Lua", "https://blog.oat.zone/content/images/2022/04/lua.png"},
        py = {
            "Python",
            "https://ih1.redbubble.net/image.1065285617.2173/flat,750x,075,f-pad,750x1000,f8f8f8.u1.jpg"
        },
        yaml = {"YAML", "https://avatars.githubusercontent.com/u/70907734?v=4"},
        nix = {
            "Nix",
            "https://camo.githubusercontent.com/8c73ac68e6db84a5c58eef328946ba571a92829b3baaa155b7ca5b3521388cc9/68747470733a2f2f692e696d6775722e636f6d2f367146436c41312e706e67"
        },
        md = {
            "Markdown", "https://avatars.githubusercontent.com/u/70907734?v=4"
        },
        zsh = {"shell", "https://avatars.githubusercontent.com/u/70907734?v=4"},
        json = {"JSON", "https://avatars.githubusercontent.com/u/70907734?v=4"},
        conf = {
            "Configuration file",
            "https://avatars.githubusercontent.com/u/70907734?v=4"
        },
        config = {
            "Configuration file",
            "https://avatars.githubusercontent.com/u/70907734?v=4"
        },
        sql = {"SQL", "https://avatars.githubusercontent.com/u/70907734?v=4"}
    },
    auto_update = true,
    neovim_image_text = "LunarVim",
    -- main_image = "https://static-00.iconduck.com/assets.00/apps-neovim-icon-512x512-w4ecv3uh.png",
    main_image = "file",
    log_level = nil,
    client_id = "793271441293967371",
    show_time = true,
    workspace_text = function() return "ssssssss" end
})

-- Nvim-Colorizer Plugin
require'colorizer'.setup()

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

require("catppuccin").setup({
    flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
    background = {light = "latte", dark = "mocha"},
    dim_inactive = {
        enabled = false,
        -- Dim inactive splits/windows/buffers.
        -- NOT recommended if you use old palette (a.k.a., mocha).
        shade = "dark",
        percentage = 0.15
    },
    transparent_background = transparent_background,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = true,
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    styles = {
        comments = {"italic"},
        properties = {"italic"},
        functions = {"italic", "bold"},
        keywords = {"italic"},
        operators = {"bold"},
        conditionals = {"bold"},
        loops = {"bold"},
        booleans = {"bold", "italic"},
        numbers = {},
        types = {},
        strings = {},
        variables = {}
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = {"italic"},
                hints = {"italic"},
                warnings = {"italic"},
                information = {"italic"}
            },
            underlines = {
                errors = {"underline"},
                hints = {"underline"},
                warnings = {"underline"},
                information = {"underline"}
            }
        },
        aerial = false,
        barbar = false,
        beacon = false,
        cmp = true,
        coc_nvim = false,
        dap = {enabled = true, enable_ui = true},
        dashboard = false,
        fern = false,
        fidget = true,
        gitgutter = false,
        gitsigns = true,
        harpoon = false,
        hop = true,
        illuminate = true,
        indent_blankline = {enabled = true, colored_indent_levels = false},
        leap = false,
        lightspeed = false,
        lsp_saga = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = false,
        navic = {enabled = false},
        neogit = false,
        neotest = false,
        neotree = {enabled = false, show_root = true, transparent_panel = false},
        noice = false,
        notify = true,
        nvimtree = true,
        overseer = false,
        pounce = false,
        semantic_tokens = false,
        symbols_outline = false,
        telekasten = false,
        telescope = true,
        treesitter_context = false,
        ts_rainbow = true,
        vim_sneak = false,
        vimwiki = false,
        which_key = true
    },
    color_overrides = {
        mocha = {
            rosewater = "#F5E0DC",
            flamingo = "#F2CDCD",
            mauve = "#DDB6F2",
            pink = "#F5C2E7",
            red = "#F28FAD",
            maroon = "#E8A2AF",
            peach = "#F8BD96",
            yellow = "#FAE3B0",
            green = "#ABE9B3",
            blue = "#96CDFB",
            sky = "#89DCEB",
            teal = "#B5E8E0",
            lavender = "#C9CBFF",

            text = "#D9E0EE",
            subtext1 = "#BAC2DE",
            subtext0 = "#A6ADC8",
            overlay2 = "#C3BAC6",
            overlay1 = "#988BA2",
            overlay0 = "#6E6C7E",
            surface2 = "#6E6C7E",
            surface1 = "#575268",
            surface0 = "#302D41",

            base = "#1E1E2E",
            mantle = "#1A1826",
            crust = "#161320"
        }
    },
    highlight_overrides = {
        mocha = function(cp)
            return {
                -- For base configs.
                NormalFloat = {
                    fg = cp.text,
                    bg = transparent_background and cp.none or cp.base
                },
                CursorLineNr = {fg = cp.green},
                Search = {bg = cp.surface1, fg = cp.pink, style = {"bold"}},
                IncSearch = {bg = cp.pink, fg = cp.surface1},
                Keyword = {fg = cp.pink},
                Type = {fg = cp.blue},
                Typedef = {fg = cp.yellow},
                StorageClass = {fg = cp.red, style = {"italic"}},

                -- For native lsp configs.
                DiagnosticVirtualTextError = {bg = cp.none},
                DiagnosticVirtualTextWarn = {bg = cp.none},
                DiagnosticVirtualTextInfo = {bg = cp.none},
                DiagnosticVirtualTextHint = {fg = cp.rosewater, bg = cp.none},

                DiagnosticHint = {fg = cp.rosewater},
                LspDiagnosticsDefaultHint = {fg = cp.rosewater},
                LspDiagnosticsHint = {fg = cp.rosewater},
                LspDiagnosticsVirtualTextHint = {fg = cp.rosewater},
                LspDiagnosticsUnderlineHint = {sp = cp.rosewater},

                -- For fidget.
                FidgetTask = {bg = cp.none, fg = cp.surface2},
                FidgetTitle = {fg = cp.blue, style = {"bold"}},

                -- For trouble.nvim
                TroubleNormal = {bg = cp.base},

                -- For treesitter.
                ["@field"] = {fg = cp.rosewater},
                ["@property"] = {fg = cp.yellow},

                ["@include"] = {fg = cp.teal},
                -- ["@operator"] = { fg = cp.sky },
                ["@keyword.operator"] = {fg = cp.sky},
                ["@punctuation.special"] = {fg = cp.maroon},

                -- ["@float"] = { fg = cp.peach },
                -- ["@number"] = { fg = cp.peach },
                -- ["@boolean"] = { fg = cp.peach },

                ["@constructor"] = {fg = cp.lavender},
                -- ["@constant"] = { fg = cp.peach },
                -- ["@conditional"] = { fg = cp.mauve },
                -- ["@repeat"] = { fg = cp.mauve },
                ["@exception"] = {fg = cp.peach},

                ["@constant.builtin"] = {fg = cp.lavender},
                -- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
                -- ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
                ["@type.qualifier"] = {link = "@keyword"},
                ["@variable.builtin"] = {fg = cp.red, style = {"italic"}},

                -- ["@function"] = { fg = cp.blue },
                ["@function.macro"] = {fg = cp.red, style = {}},
                ["@parameter"] = {fg = cp.rosewater},
                ["@keyword"] = {fg = cp.red, style = {"italic"}},
                ["@keyword.function"] = {fg = cp.maroon},
                ["@keyword.return"] = {fg = cp.pink, style = {}},

                -- ["@text.note"] = { fg = cp.base, bg = cp.blue },
                -- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
                -- ["@text.danger"] = { fg = cp.base, bg = cp.red },
                -- ["@constant.macro"] = { fg = cp.mauve },

                -- ["@label"] = { fg = cp.blue },
                ["@method"] = {fg = cp.blue, style = {"italic"}},
                ["@namespace"] = {fg = cp.rosewater, style = {}},

                ["@punctuation.delimiter"] = {fg = cp.teal},
                ["@punctuation.bracket"] = {fg = cp.overlay2},
                -- ["@string"] = { fg = cp.green },
                -- ["@string.regex"] = { fg = cp.peach },
                ["@type"] = {fg = cp.yellow},
                ["@variable"] = {fg = cp.text},
                ["@tag.attribute"] = {fg = cp.mauve, style = {"italic"}},
                ["@tag"] = {fg = cp.peach},
                ["@tag.delimiter"] = {fg = cp.maroon},
                ["@text"] = {fg = cp.text},

                -- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
                -- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
                -- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
                -- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
                -- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
                -- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
                -- ["@string.escape"] = { fg = cp.pink },

                -- ["@property.toml"] = { fg = cp.blue },
                -- ["@field.yaml"] = { fg = cp.blue },

                -- ["@label.json"] = { fg = cp.blue },

                ["@function.builtin.bash"] = {fg = cp.red, style = {"italic"}},
                ["@parameter.bash"] = {fg = cp.yellow, style = {"italic"}},

                ["@field.lua"] = {fg = cp.lavender},
                ["@constructor.lua"] = {fg = cp.flamingo},

                ["@constant.java"] = {fg = cp.teal},

                ["@property.typescript"] = {
                    fg = cp.lavender,
                    style = {"italic"}
                },
                -- ["@constructor.typescript"] = { fg = cp.lavender },

                -- ["@constructor.tsx"] = { fg = cp.lavender },
                -- ["@tag.attribute.tsx"] = { fg = cp.mauve },

                ["@type.css"] = {fg = cp.lavender},
                ["@property.css"] = {fg = cp.yellow, style = {"italic"}},

                ["@type.builtin.c"] = {fg = cp.yellow, style = {}},

                ["@property.cpp"] = {fg = cp.text},
                ["@type.builtin.cpp"] = {fg = cp.yellow, style = {}}

                -- ["@symbol"] = { fg = cp.flamingo },
            }
        end
    }
})
