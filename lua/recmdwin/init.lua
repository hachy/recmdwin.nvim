local M = {}

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_cr()
  return vim.fn.pumvisible() == 1 and t "<C-y><CR>" or t "<CR>"
end

function M.setup()
  local recmdwin = vim.api.nvim_create_augroup("ReCmdwin", {})

  vim.api.nvim_create_autocmd("CmdwinEnter", {
    group = recmdwin,
    callback = function()
      if vim.fn.getcmdwintype() == ":" then
        local old_undolevels = vim.api.nvim_buf_get_option(0, "undolevels")
        vim.api.nvim_buf_set_option(0, "undolevels", -1)
        vim.cmd [[silent keeppatterns g/^qa\?!\?$/d_]]
        vim.cmd [[silent keeppatterns g/^wq\?a\?!\?$/d_]]
        vim.api.nvim_buf_set_option(0, "undolevels", old_undolevels)
      end

      vim.api.nvim_buf_set_keymap(0, "n", "q", "<Cmd>quit<CR>", {
        nowait = true,
        noremap = true,
        silent = true,
      })
      vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "v:lua.smart_cr()", { noremap = true, expr = true })

      vim.opt_local.number = false
      vim.opt_local.signcolumn = "no"

      local row = vim.api.nvim_buf_line_count(0)
      vim.api.nvim_win_set_cursor(0, { row, 0 })
      vim.cmd "startinsert!"
    end,
  })
end

return M
