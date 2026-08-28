-- Options load before lazy.nvim startup.
-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.swapfile = false
vim.opt.undofile = true

-- C/C++ package manager (picked up by cmake / clang tooling)
vim.env.VCPKG_ROOT = vim.fn.expand("~/.local/share/vcpkg")

-- .NET: Roslyn/MSBuild need this when nvim is started outside a login shell
if not vim.env.DOTNET_ROOT and vim.fn.isdirectory("/usr/share/dotnet") == 1 then
  vim.env.DOTNET_ROOT = "/usr/share/dotnet"
end
