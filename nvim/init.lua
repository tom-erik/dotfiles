-- Provide a global `keymap()` function everywhere.
keymap = vim.keymap.set

-- use space as a the leader key
-- We do this in `init` because <leader> isn't lazy processed.  If a
-- plugin is using it as part of the keymapping they will use whatever
-- is defined at the time.
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("tomerik.plugins-setup")
require("tomerik.core.options")
require("tomerik.core.keymaps")
require("tomerik.core.colorscheme")
require("tomerik.plugins.comment")
require("tomerik.plugins.nvim-tree")
require("tomerik.plugins.lualine")
require("tomerik.plugins.telescope")
require("tomerik.plugins.nvim-cmp")
require("tomerik.plugins.lsp.mason")
require("tomerik.plugins.lsp.lspsaga")
require("tomerik.plugins.lsp.lspconfig")
require("tomerik.plugins.lsp.null-ls")
require("tomerik.plugins.autopairs")
require("tomerik.plugins.treesitter")
require("tomerik.plugins.gitsigns")
