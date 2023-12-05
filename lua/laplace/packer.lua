--false This file can be loaded by calling `lua require("plugins")` from your init.vim

vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    use {
        "mbbill/undotree",
        config = function() vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) end
    }
    
    use {
        "folke/trouble.nvim",
        requires = { "nvim-tree/nvim-web-devicons" },
        config = function () 
            require("trouble").setup {}
            vim.keymap.set("n", "<leader>xx", function () require("trouble").toggle() end)
        end
    }

    use {
        "tpope/vim-fugitive",
        config = function() vim.keymap.set("n", "<leader>gs", vim.cmd.Git) end
    }
    
    use {
        "lewis6991/gitsigns.nvim",
        config = function () require("gitsigns").setup {} end
    }
    
    use {
        "windwp/nvim-autopairs",
        config = function () require("nvim-autopairs").setup {} end
    }
    
    use {
        "windwp/nvim-ts-autotag",
        config = function () require("nvim-ts-autotag").setup {} end
    }

    use {
        "Pocco81/auto-save.nvim",
        config = function ()
            require("auto-save").setup { trigger_events = {"InsertLeave", "TextChanged", "FocusLost", "VimLeavePre"} }
        end
    }

    -- requires nvim 0.10 which is still experimental
    -- use {
    --     "Bekaboo/dropbar.nvim",
    --     requires = { "nvim-telescope/telescope-fzf-native.nvim" }
    -- }

    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
        config = function ()
            require("lualine").setup { theme = "material" }
        end
    }

    use {
        "marko-cerovac/material.nvim",
        as = "material",
        config = function ()
            require("material").setup { disable = { background = true } }
            vim.g.material_style = "palenight"
            vim.cmd.colorscheme("material")
        end
    }

    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.4",
        -- or                          , branch = "0.1.x",
        requires = { {"nvim-lua/plenary.nvim"} },
        config = function ()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
            vim.keymap.set("n", "<C-p>", builtin.git_files, {})
            vim.keymap.set("n", "<leader>ps", function() 
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
        end
    }

    use {
        "theprimeagen/harpoon",
        config = function ()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
        end
    }
    
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function ()
            require"nvim-treesitter.configs".setup {
                ensure_installed = { "html", "css", "javascript",
                "typescript", "go", "python", "c","markdown_inline",
                "json", "lua" },
                
                sync_install = false,
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    }

    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"},

            -- LSP Support
            {"neovim/nvim-lspconfig"},

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-path"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"L3MON4D3/LuaSnip"},
            {"saadparwaiz1/cmp_luasnip"},
            
            -- Snippets
            {"rafamadriz/friendly-snippets"}
        },
        config = function()
            local lsp_zero = require("lsp-zero")

            lsp_zero.on_attach(function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end)
    
            -- Configure LSPs
            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "lua_ls",
                    "gopls",
                    "tsserver",
                    "html",
                    "cssls",
                    "eslint",
                    "tailwindcss",
                    "pyright"
                },
                handlers = {
                    lsp_zero.default_setup,
                }
            })
            
            -- Configure Snippets
            require "luasnip/loaders/from_vscode".lazy_load()
            
            -- Configure Autocompletion Suggestions
            local cmp = require "cmp"
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = {
                    {name = "path"},
                    {name = "nvim_lsp"},
                    {name = "nvim_lua"},
                    {name = "luasnip"}
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-X>"] = cmp.mapping(cmp.mapping.complete({
                        reason = cmp.ContextReason.Auto
                    }), {"i", "c"}),
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                }
            })
        end
    }
end)
