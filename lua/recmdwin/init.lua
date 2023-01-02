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
    pattern = ":",
    callback = function()
      vim.cmd [[g/^qa\?!\?$/d_]]
      vim.cmd [[g/^wq\?a\?!\?$/d_]]
    end,
  })

  vim.api.nvim_create_autocmd("CmdwinEnter", {
    group = recmdwin,
    callback = function()
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
