return require("packer").startup(function(use)
    -- Plugin manager
    -- Stores in /home/paul/.local/share/nvim/site/pack/packer/
    use "wbthomason/packer.nvim"

    -- Theme
    use "rebelot/kanagawa.nvim"

    -- Icons
    use "nvim-tree/nvim-web-devicons"

    -- Statusline
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }

    -- Indentation
    use "lukas-reineke/indent-blankline.nvim"

    -- Highlight
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }

    -- New text objects
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })

    -- Comments
    use "numToStr/Comment.nvim"

    -- Package manager
    use { "williamboman/mason.nvim", run = ":MasonUpdate" }
    use "williamboman/mason-lspconfig.nvim"

    -- LSP support
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"

    -- Completion
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"

    -- Function signature
    use "ray-x/lsp_signature.nvim"

    -- Snippets
    use { "L3MON4D3/LuaSnip", tag = "v1.*", run = "make install_jsregexp" }
    use "saadparwaiz1/cmp_luasnip"
    use "rafamadriz/friendly-snippets"

    -- Fuzzy finder
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.1",
        requires = { "nvim-lua/plenary.nvim" }
    }
    -- Finder algorithm
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- Blazingly fast file navigation
    use "ThePrimeagen/harpoon"

end)
