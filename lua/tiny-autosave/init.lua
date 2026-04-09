local M = {}

function M.setup(opts)
  opts = opts or {}
  local events = opts.events or { "InsertLeave", "TextChanged", "FocusLost" }

  vim.opt.autowrite = true
  vim.opt.autowriteall = true

  vim.api.nvim_create_autocmd(events, {
    group = vim.api.nvim_create_augroup("tiny-autosave", { clear = true }),
    callback = function()
      local name = vim.api.nvim_buf_get_name(0)
      if name ~= "" and vim.fn.filereadable(name) == 0 then
        vim.fn.mkdir(vim.fn.fnamemodify(name, ":p:h"), "p")
      end
      vim.cmd("silent! write")
      vim.cmd("silent! wall")
    end,
  })
end

return M
