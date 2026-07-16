-- Apps Config

local HOME = os.getenv("HOME")
local config = HOME .. "/.config"

Apps = {
	terminal = "kitty",
	filemanager = "nautilus",
	filemanager_cli = "yazi",
	browser = "zen-browser",
	discord = "discord",
	steam = "steam",
	spotify = "spotify --password-store=basic",
	localMusic = "kew",
	soundVusualizer = "cava",
	cli_clock = "clock-rs",
	editor = "nvim",
	notificationClient = "swaync-client",
	logout = "wlogout",
	screenLock = "hyprlock",
	takeScreenshot = "hyprshot -m output --raw | satty --filename -",
}

Service = {
	polkitagent = "sleep 5 && systemctl --user start hyprpolkitagent",
	portal = "systemctl --user start xdg-desktop-portal-hyprland",
	sessionTarget = "systemctl --user start hyprland-session.target",

	spotifyNotifications = "systemctl --user start spotify-notify.service",
	archUpdate = "sleep 3 && arch-update --tray",

	malwareCheck = "./.config/bin/services/malwareCheck.sh",

	notificationCenter = "swaync",
	bar = "waybar",
	wallpaperEngine = "awww-daemon",

	editConfig = "/.config/bin/utils/editConfig",
	reloadDesktop = "/.config/bin/helper/reloadDesktop.sh",

	systemUpdate = "arch-update",

	startOverview = "qs -c overview",
	toggleOverview = "qs ipc -c overview call overview toggle",

	forceKill = "hyprctl kill",
	hyprshutdown = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'",
}

Menu = {
	runner = config .. "/rofi/launcher.sh 'show drun' runner",
	themeSwitcher = config .. "/bin/UI/themeMenu.sh",
	wallpaperSelector = config .. "/bin/UI/wallpaperSelector.sh",
}
