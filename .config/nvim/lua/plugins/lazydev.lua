return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- Hyprland config Lua API stubs
        { path = vim.fn.expand("~/.config/hypr/stubs/"), words = { "hl%." } },
      },
    },
  },
}
