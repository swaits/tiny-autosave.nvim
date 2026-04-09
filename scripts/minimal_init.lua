-- Minimal init for testing tiny-autosave.nvim
vim.opt.rtp:prepend(".")
vim.opt.rtp:prepend("deps/mini.nvim")
vim.cmd("runtime plugin/tiny-autosave.lua")
