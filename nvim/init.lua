local g = vim.g
local fn = vim.fn
local opt = vim.opt
local home_dir = os.getenv("HOME")
local command = vim.api.nvim_command
opt.termguicolors = true
g.mapleader = " "
g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {"norcalli/nvim-colorizer.lua", 
        opts = {
            '*';
            DEFAULT_OPTIONS = {
            RGB      = true;         -- #RGB hex codes
            RRGGBB   = true;         -- #RRGGBB hex codes
            names    = true;         -- "Name" codes like Blue
            RRGGBBAA = true;        -- #RRGGBBAA hex codes
            rgb_fn   = true;        -- CSS rgb() and rgba() functions
            hsl_fn   = true;        -- CSS hsl() and hsla() functions
            css      = true;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn   = true;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Available modes: foreground, background
            mode     = 'foreground';
          }
        } 
    },
    {"windwp/nvim-autopairs",
        opts = {
            event = "InsertEnter",
            config = true
        }
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
        },
    },
    {"xiyaowong/nvim-transparent"},
    {"nvim-treesitter/nvim-treesitter",
        config = function()
            require('nvim-treesitter.configs').setup({
                build = ":TSUpdate",
                highlight = { enable = true },
                indent = { enable = true },
                ensure_installed = {
                    "bash", "c", "diff", "html", "javascript", "jsdoc", "json", "jsonc", "lua",
                    "luadoc", "luap", "markdown", "markdown_inline", "printf", "python", "query",
                    "regex", "toml", "tsx", "java", "typescript", "vim", "vimdoc", "xml", "yaml",
                },
                sync_install = false,
            })
        end,
    },
    {"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}},
    {"neovim/nvim-lspconfig"},
    {
    "jose-elias-alvarez/null-ls.nvim",
        ft = {"python"},
        dependencies = {
            "williamboman/mason.nvim",      -- Ensure mason is installed
            "williamboman/mason-lspconfig.nvim",
            "jayp0521/mason-null-ls.nvim",  -- Add mason-null-ls integration
        }
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "pyright",
            },
        },
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        build = ":MasonUpdate",
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                lazy = false,
            },
        },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "",
                        package_pending = "",
                        package_uninstalled = "",
                    },
                }
            })
            require("mason-lspconfig").setup()
        end,
    },
    {"mg979/vim-visual-multi", lazy = false},
    {"hrsh7th/nvim-cmp"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/cmp-buffer"},
	{"hrsh7th/cmp-path"},
	{"hrsh7th/cmp-cmdline"},
	{"hrsh7th/cmp-vsnip"},
    {"hrsh7th/cmp-vsnip"},
	{"hrsh7th/vim-vsnip"},
    {"uga-rosa/cmp-dictionary"},
    {"kyazdani42/nvim-web-devicons"},
    {"robbles/logstash.vim"},
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
    },
    {"mfussenegger/nvim-dap",
	    dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio", -- Add this line
	    },
	    config = function()
		require("dapui").setup()
		require("nvim-dap-virtual-text").setup()
	    end,
	},
    {
      'Exafunction/codeium.vim',
      event = 'BufEnter'
    },
    {"rafamadriz/friendly-snippets"},
    {"lewis6991/gitsigns.nvim"},
    {"folke/which-key.nvim"},
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" }},
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.cmd[[colorscheme tokyonight]]

-- Cursor
command("set guicursor=")
opt.cursorline = true
opt.cursorlineopt = "number"

-- Line numbers
opt.number = true
opt.relativenumber = false

-- Keep changes on file when changing buffers and ask for confirmation when
-- closing modified files
opt.hidden = true
opt.confirm = true

opt.swapfile = false
opt.backup = false
opt.undodir = home_dir .. "/.vim/undodir"
opt.undofile = true

-- Ignore case but smartcase when there's a capital letter on search term
opt.ignorecase = true
opt.smartcase = true

-- Tabs
opt.expandtab = true
opt.smarttab = true
opt.softtabstop = 4
opt.shiftwidth = 4
opt.tabstop = 4

-- Scrolls when 8 columns away from edge
opt.scrolloff = 10

opt.wrap = false


-- Statusline
opt.cmdheight = 1
opt.laststatus = 3

-- Spell checking
require("cmp_dictionary").setup({
	dic = {
		["markdown"] = { "/usr/share/dict/british-english" },
	},
})
opt.spelllang = { "en", "cjk", "pt_br" }
opt.spellsuggest = { "best", "9" }

-- Maps

map("n", "<Esc>", ":noh<CR>", {silent = true}) 

map("n", "<Leader>spell", ":set spell!<CR>", { silent = true })

--- Keep indenting selected on visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- telescope.nvim
map("n", "<C-f>", ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", { silent = true })
map("n", "<C-b>", ":Telescope buffers<CR>", { silent = true })
map("n", "<Leader>tr", "<cmd>Telescope resume<CR>", { silent = true })
map("n", "<Leader>r", "<cmd>Telescope live_grep<CR>", { silent = true })
map("n", "<Leader>d", "<cmd>Telescope diagnostics<CR>", { silent = true })
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })

-- copy and paste
map("v", "<C-C>", '"+y')
map("", "<C-V>", '"+p')

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("mason").setup({})
require("mason-lspconfig").setup({
	automatic_installation = true,
})

local lsp_util = require("lspconfig.util")

lsp_util.default_config = vim.tbl_extend("force", lsp_util.default_config, {
	capabilities = capabilities,
})

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "awesome" }, disable = { "lowercase-global" } },
			runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
			workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
			telemetry = {
				enable = false,
			},
			format = {
				enable = false,
			},
		},
	},
})

lspconfig.pyright.setup({
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
			},
		},
	},
})

lspconfig.jdtls.setup({
    cmd = { 'jdtls' },
    root_dir = lsp_util.root_pattern('.git', 'mvnw', 'gradlew'),
})

-- Initialize Mason for managing LSP servers and external tools
require("mason").setup()

-- Mason-null-ls setup for Python tools (black, pylint, isort)
require("mason-null-ls").setup({
    ensure_installed = { "black", "pylint", "isort" },
})

-- Null-ls setup for Python (formatter, linter, import sorter)
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- Python formatter (Black)
        null_ls.builtins.formatting.black.with({
            extra_args = { "--fast" },  -- Optional: Makes formatting faster
        }),

        -- Python import sorter (isort)
        null_ls.builtins.formatting.isort,

        -- Python linter (Pylint)
        null_ls.builtins.diagnostics.pylint.with({
            args = { "--output-format", "json", "--max-line-length", "100", "--disable=missing-module-docstring", "$FILENAME" },
        }),
    },
})

-- Define the custom_attach function
local custom_attach = function(client, bufnr)
  -- Keybindings for LSP
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)  -- Go to definition
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)  -- Find references
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)  -- Show hover info
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)  -- Rename symbol
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)  -- Code actions
end

lspconfig.pylsp.setup({
    on_attach = custom_attach,
    settings = {
        pylsp = {
            plugins = {
                -- Formatter options
                black = { enabled = true },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                -- Linter options
                pylint = { enabled = true, executable = "pylint" },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                -- Type checker
                pylsp_mypy = { enabled = true },
                -- Auto-completion options
                jedi_completion = { fuzzy = true },
                -- Import sorting
                pyls_isort = { enabled = true },
            },
        },
    },
    flags = {
        debounce_text_changes = 200,
    },
    capabilities = capabilities,
})

-- Set up autocmd to trigger formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function()
        -- This will trigger the formatter for Python files using null-ls
        vim.lsp.buf.format({ async = true })
    end,
})

opt.completeopt = "menu,menuone,noselect"
local cmp = require("cmp")
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "calc" },
		{ name = "treesitter" },
		{ name = "dictionary", keyword_length = 2 },
	}),
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			winhighlight = "NormalFloat:NormalFloat,FloatBorder:NormalFloat",
			max_width = 120,
			min_width = 60,
			max_height = math.floor(vim.o.lines * 0.3),
			min_height = 1,
		},
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				buffer = "[BUF]",
				vsnip = "[SNIP]",
			})[entry.source.name]
			return vim_item
		end,
	},
})

cmp.setup.cmdline("/", { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } })
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = "" } }))
