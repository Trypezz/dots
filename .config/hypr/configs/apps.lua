-- Apps Config

local HOME = os.getenv("HOME")
local config = HOME .. "/.config"

-- Services
Apps = {
	polkitagent = "systemctl --user start hyprpolkitagent",
	archUpdate = "sleep 3 && arch-update --tray",
	notificationCenter = "swaync",
	spotifyNotifications = "systemctl --user start spotify-notify.service",
	bar = "waybar",
	wallpaperEngine = "awww-daemon",

	-- Apps
	terminal = "kitty",
	appmenu = config .. "/rofi/launcher.sh 'show drun' runner",
	filemanager = "nautilus",
	browser = "zen-browser",
	discord = "discord",
	steam = "steam",
	music = "spotify --password-store=basic",
	editor = "nvim",

	-- UI Scripts
	themeSwitcher = config .. "/bin/UI/themeMenu.sh",
	wallpaperSelector = config .. "/bin/UI/wallpaperSelector.sh",
}
