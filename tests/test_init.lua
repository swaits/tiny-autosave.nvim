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

T["save"] = MiniTest.new_set()

T["save"]["fires BufWritePre once and applies formatter changes"] = function()
  require("tiny-autosave").setup()
  local tmp = vim.fn.tempname() .. ".txt"
  vim.cmd("edit " .. tmp)
  local buf = vim.api.nvim_get_current_buf()
  local pre_count = 0
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buf,
    callback = function()
      pre_count = pre_count + 1
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "formatted" })
    end,
  })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "original", "", "", "" })
  vim.api.nvim_exec_autocmds("InsertLeave", { buffer = buf })
  eq(pre_count, 1)
  eq(vim.fn.readfile(tmp), { "formatted" })
  os.remove(tmp)
end

T["save"]["skips unnamed buffers"] = function()
  require("tiny-autosave").setup()
  vim.cmd("enew")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "scratch" })
  local ok = pcall(vim.api.nvim_exec_autocmds, "InsertLeave", {})
  eq(ok, true)
end

T["save"]["skips unmodified buffers"] = function()
  require("tiny-autosave").setup()
  local tmp = vim.fn.tempname() .. ".txt"
  vim.fn.writefile({ "hello" }, tmp)
  vim.cmd("edit " .. tmp)
  local buf = vim.api.nvim_get_current_buf()
  local pre_count = 0
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buf,
    callback = function()
      pre_count = pre_count + 1
    end,
  })
  vim.api.nvim_exec_autocmds("InsertLeave", { buffer = buf })
  eq(pre_count, 0)
  os.remove(tmp)
end

return T
