return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "~/.config/hypr/stubs/", words = { "hl%." } },

        { path = "${3rd}/luv/library", words = { "vim%.uv" } },

        { path = "/usr/share/hypr/stubs/", words = { "hl%." } },
      },
    },
  },
}
