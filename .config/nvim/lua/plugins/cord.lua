-- Discord Rich Presence: shows file + workspace while coding
return {
  {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      editor = {
        client = "neovim",
        tooltip = "Neovim",
      },
      display = {
        theme = "default",
        flavor = "dark",
        view = "full",
      },
      timestamp = {
        enabled = true,
      },
      idle = {
        enabled = false,
      },
      text = {
        viewing = "Viewing ${filename}",
        editing = "Editing ${filename}",
        file_browser = "Browsing files",
        plugin_manager = "Managing plugins",
        lsp = "Configuring LSP",
        docs = "Reading ${filename}",
        vcs = "Git: ${filename}",
        terminal = "In terminal",
        workspace = "Working on ${workspace}",
      },
      variables = true,
    },
  },
}
