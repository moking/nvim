local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--require('lazy').setup("plugins")
require('lazy').setup(
        "plugins",
      {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({})
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
})

-- Vim mappings, see lua/config/which.lua for more mappings
require("mappings")

-- All non plugin related (vim) options
require("options")

-- Vim autocommands/autogroups
require("autocmds")

-- Set favorite colorscheme
require("colorscheme")

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        if opts.desc then
            opts.desc = "keymaps.lua: " .. opts.desc
        end
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- here some of my mappings:
-- jump to the last changed spot
--map("n", "<f12>", "<C-]>", { desc = "Jump to definition"})
--map("n", "<f11>", "<C-t>", { desc = "Jump back from definition"})
map("n", "<C-x>2", "<esc>:split<cr>", { desc = ""})
map("n", "<C-x>3", "<esc>:vsplit<cr>", { desc = ""})
map("n", "rb", "o<enter>Reviewed-by: Fan Ni <fan.ni@samsung.com><enter><esc>", { desc = ""})
map("n", "tb", "o<enter>Tested-by: Fan Ni <fan.ni@samsung.com><enter><esc>", { desc = ""})
map("n", "qq", "<esc>:q<cr>", { desc = "save buffer"})

map("n", "<f2>", "<esc>:w<cr>", { desc = "save buffer"})
map("i", "<f2>", "<esc>:w<cr>", { desc = "save buffer"})
map("n", "<f3>", "<esc>:set list!<cr>", { desc = ""})
map("n", "<f4>", "<esc>:set expandtab!<cr>", { desc = ""})
map("n", "<f5>", "<esc>:GitGutterQuickFix | copen <return>", { desc = ""})
-- map("n", "<f5>", "<esc>:GitGutterQuickFix \| copen <return>", { desc = ""})



