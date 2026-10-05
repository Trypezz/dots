return {
  {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      editor = {
        client = "neovim",
        tooltip = "The Superior Text Editor",
      },
      display = {
        theme = "default",
        flavor = "dark",
        view = "full",
        swap_fields = true,
      },
      timestamp = { enabled = true },
      idle = { enabled = false },

      advanced = {
        workspace = {
          root_markers = {
            ".git",
            ".hg",
            ".svn",
            "CMakeLists.txt",
            "Makefile",
            "compile_commands.json",
            "meson.build",
            "gradle.build",
            "Cargo.toml",
            "package.json",
            "go.mod",
            "pyproject.toml",
            "*.sln",
            ".nvimroot",
          },
          limit_to_cwd = true,
        },
      },

      text = {
        workspace = function()
          local project = "Project: " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          if project == "Project: .config" then
            project = "Project: Dotfiles"
          end
          return project
        end,

        editing = function(opts)
          return file_line(opts, "Editing")
        end,
        viewing = function(opts)
          return file_line(opts, "Viewing")
        end,
        docs = function(opts)
          return file_line(opts, "Reading")
        end,

        file_browser = "Browsing files",
        plugin_manager = "Managing plugins",
        lsp = "Configuring LSP",
        vcs = "Git",
        terminal = "In terminal",
      },
    },
    config = function(_, opts)
      local function parent_folder()
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" then
          return nil
        end
        local dir = vim.fs.dirname(path)
        if not dir or dir == "" then
          return nil
        end
        return vim.fs.basename(dir)
      end

      function file_line(opts, action)
        local name = opts.filename or "a file"
        local line = action .. ":  " .. name
        local folder = parent_folder()
        local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        if folder and folder ~= "" and folder ~= project then
          if folder == "plugins" then
            line = "Managing Plugins · " .. line
          elseif folder == "E0" then
            line = "Working on the German Translation · Translating SEBEC-Route"
          elseif folder == "E1" then
            line = "Working on the German Translation · Translating Snow Queen Events"
          elseif folder:match("^E%d+$") then
            line = "Working on the German Translation for Revelations:Persona"
          elseif folder == "eboot" then
            line = "Working on the German Translation · " .. line
          else
            line = "Working on " .. folder .. " · " .. line
          end
        end
        return line
      end

      require("cord").setup(opts)
    end,
  },
}
