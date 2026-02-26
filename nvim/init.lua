vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.termguicolors = true
vim.o.autoindent = true
vim.o.cursorline = true
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
-- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
-- vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
vim.keymap.set('n', '<Leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<cr>')

require("bootstrap_lazy")
require("lazy").setup({
    "tpope/vim-surround",
    "tpope/vim-fugitive",
    "neovim/nvim-lspconfig",
    "numToStr/Comment.nvim",
    "folke/which-key.nvim",
    "ellisonleao/gruvbox.nvim",
    "RRethy/vim-illuminate",
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require 'nvim-treesitter.configs'.setup { ensure_installed = {"python"} }
        end

    },
    {
        "windwp/nvim-ts-autotag",
        lazy = false,
        config = function()
            require("nvim-ts-autotag").setup({})
        end,
    },
    {
        "airblade/vim-gitgutter",
        config = function()
            vim.api.nvim_create_autocmd({"BufWritePost"}, {command="GitGutter"})
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer",   -- Buffer source
            "hrsh7th/cmp-path",     -- Path source
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),

            })
        end,
    },
    {
        'nvim-telescope/telescope.nvim', tag = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, { desc = 'Telescope definitions' })

        end
    },
    {"b4winckler/vim-angry"},
    {
        "exdis/argwrap.nvim",
        keys = {
            { "<leader>a", function() require("argwrap").toggle() end, desc = "Toggle argument wrap" },
        },
        opts = {
            tail_comma = true,
            wrap_closing_brace = true,
            padded_braces = "",
            line_prefix = "",
        },
        config = function(_, opts)
            require("argwrap").setup(opts)
        end,
    },
})


vim.cmd([[colorscheme gruvbox]])
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("pylsp")
vim.lsp.enable("lua_ls")
