local opts = { noremap = true, silent = true }

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap("i", "jk", "<ESC>")

-- clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap("n", "x", '"_x')

-- increment/decrement numbers
keymap("n", "<leader>+", "<C-a>") -- increment
keymap("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>") -- close current split window

keymap("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Resize windows with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<leader>l", ":bnext<CR>", opts)
keymap("n", "<leader>h", ":bprevious<CR>", opts)

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
