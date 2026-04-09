local T = MiniTest.new_set()
local eq = MiniTest.expect.equality

T["setup"] = MiniTest.new_set()

T["setup"]["creates augroup"] = function()
  local groups = vim.api.nvim_get_autocmds({ group = "tiny-autosave" })
  eq(#groups > 0, true)
end

T["setup"]["is idempotent"] = function()
  require("tiny-autosave").setup()
  require("tiny-autosave").setup()
  local groups = vim.api.nvim_get_autocmds({ group = "tiny-autosave" })
  eq(#groups > 0, true)
end

T["setup"]["respects custom events"] = function()
  require("tiny-autosave").setup({ events = { "InsertLeave" } })
  local groups = vim.api.nvim_get_autocmds({ group = "tiny-autosave" })
  eq(#groups, 1)
end

return T
