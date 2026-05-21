vim.g.mapleader = " " -- space as leader

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- open netrw

-- LSP navigation
vim.keymap.set("n", "gd", vim.lsp.buf.definition,     { silent = true }) -- go to definition
vim.keymap.set("n", "gD", vim.lsp.buf.declaration,    { silent = true }) -- go to declaration
vim.keymap.set("n", "gr", vim.lsp.buf.references,     { silent = true }) -- list references
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true }) -- go to implementation
vim.keymap.set("n", "K",  vim.lsp.buf.hover,          { silent = true }) -- hover docs
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,      { silent = true }) -- rename symbol
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true }) -- code actions

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selection up

vim.keymap.set("n", "J",     "mzJ`z")     -- join lines, preserve cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")  -- scroll down, center
vim.keymap.set("n", "<C-u>", "<C-u>zz")  -- scroll up, center
vim.keymap.set("n", "n",     "nzzzv")    -- next result, center
vim.keymap.set("n", "N",     "Nzzzv")    -- prev result, center
vim.keymap.set("n", "=ap",   "ma=ap'a")  -- format paragraph, restore cursor

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]]) -- paste over selection without losing register

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- yank to system clipboard
vim.keymap.set("n",           "<leader>Y", [["+Y]]) -- yank line to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")   -- delete without yanking

vim.keymap.set("i", "<C-e>", "<Esc>") -- Ctrl+e = Escape in insert mode
vim.keymap.set("n", "Q", "<nop>")     -- disable ex mode

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")         -- open sessionizer in new window
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")     -- sessionizer vsplit
vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")    -- sessionizer new window

vim.keymap.set("n", "<C-k>",     "<cmd>cnext<CR>zz") -- next quickfix item
vim.keymap.set("n", "<C-j>",     "<cmd>cprev<CR>zz") -- prev quickfix item
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- next loclist item
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz") -- prev loclist item

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- search/replace word under cursor
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })               -- make file executable

-- Go error snippets
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")                                   -- return err
vim.keymap.set("n", "<leader>ea", "oassert.NoError(err, \"\")<Esc>F\";a")                                         -- assert.NoError
vim.keymap.set("n", "<leader>ef", "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj")  -- log.Fatalf
vim.keymap.set("n", "<leader>el", "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i") -- logger.Error

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so") -- source current file
end)
