-- Hyprland Entry Point

-- 1. Theme -> Colors and sytles
require("colors.colors")

-- 2. Base (Permissions, Layout-Config, Basic Rules)
require("configs.base")

-- 3. Environment Variables
require("configs.vars")

-- 4. App Definitions -> needed by autostart + binds
require("configs.apps")

-- 5. Hardware
require("configs.monitors")
require("configs.input")

-- 6. Look & Feel -> needs Theme
require("configs.style")
require("configs.animations")

-- 7. Workspaces
require("configs.workspaces")

-- 8. Rules
require("configs.rules")

-- 9. Keybinds -> needs Apps
require("configs.binds")

-- 10. Autostart -> needs Apps
require("configs.autostart")
