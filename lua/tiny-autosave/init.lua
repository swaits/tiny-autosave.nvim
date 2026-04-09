local M = {}

function M.setup(opts)
  opts = opts or {}
  local events = opts.events or { "InsertLeave", "FocusLost" }
  vim.api.nvim_create_autocmd(events, {
    group = vim.api.nvim_create_augroup("tiny-autosave", { clear = true }),
    callback = function()
      if vim.bo.buftype == "" and vim.bo.modified then
        vim.cmd("silent! wall")
      end
    end,
  })
end

return M
