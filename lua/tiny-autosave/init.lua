local M = {}

function M.setup(opts)
  opts = opts or {}
  local events = opts.events or { "InsertLeave", "TextChanged", "FocusLost" }

  vim.opt.autowrite = true
  vim.opt.autowriteall = true

  vim.api.nvim_create_autocmd(events, {
    group = vim.api.nvim_create_augroup("tiny-autosave", { clear = true }),
    nested = true,
    callback = function(args)
      local buf = args.buf
      if vim.bo[buf].buftype ~= "" or not vim.bo[buf].modified then
        return
      end
      local name = vim.api.nvim_buf_get_name(buf)
      if name == "" then
        return
      end
      if vim.fn.filereadable(name) == 0 then
        vim.fn.mkdir(vim.fn.fnamemodify(name, ":p:h"), "p")
      end
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("silent keepalt keepjumps write")
      end)
    end,
  })
end

return M
