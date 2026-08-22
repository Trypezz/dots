-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- C Development
vim.api.nvim_create_user_command("Make", function(opts)
  vim.cmd("silent !make " .. (opts.args or ""))
  print("→ Make " .. (opts.args or "") .. " done")
end, { nargs = "*" })

vim.api.nvim_create_user_command("Run", function()
  vim.cmd("silent !make run")
end, {})
