return {
  {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      auto_update = true,
      variables = true,

      idle = {
        enabled = false,
      },

      text = {
        viewing = "Viewing ${filename}",
        editing = "Editing ${filename}",
        file_browser = "Browsing files",
        plugin_manager = "Managing plugins",
        workspace = "Workspace: ${workspace}",
      },

      show_file = true,
      show_workspace = true,
      show_line_number = false,
    },
  },
}
