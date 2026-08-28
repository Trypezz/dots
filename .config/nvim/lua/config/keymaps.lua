-- Keymaps load on the VeryLazy event.
-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local function run_make(args)
  local cmd = { "make" }
  if args and args ~= "" then
    vim.list_extend(cmd, vim.split(args, "%s+", { trimempty = true }))
  end

  vim.notify("Running: " .. table.concat(cmd, " "), vim.log.levels.INFO)
  vim.system(cmd, { text = true }, function(result)
    vim.schedule(function()
      if result.code == 0 then
        vim.notify("make finished", vim.log.levels.INFO)
      else
        local err = (result.stderr ~= "" and result.stderr) or (result.stdout ~= "" and result.stdout) or "unknown error"
        vim.notify("make failed (" .. result.code .. "):\n" .. err, vim.log.levels.ERROR)
      end
    end)
  end)
end

vim.api.nvim_create_user_command("Make", function(opts)
  run_make(opts.args)
end, { nargs = "*", desc = "Run make with optional targets" })

vim.api.nvim_create_user_command("Run", function()
  run_make("run")
end, { desc = "Run make run" })

vim.keymap.set("n", "<leader>mb", function()
  run_make()
end, { desc = "Make (default target)" })

vim.keymap.set("n", "<leader>mr", function()
  run_make("run")
end, { desc = "Make run" })
