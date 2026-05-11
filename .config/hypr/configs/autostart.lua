-- Autostart Config

hl.on("hyprland.start", function()
	hl.exec_cmd(Apps.polkitagent)
	hl.exec_cmd(Apps.archUpdate)
	hl.exec_cmd(Apps.notificationCenter)
	hl.exec_cmd(Apps.spotifyNotifications)
	hl.exec_cmd(Apps.bar)
	hl.exec_cmd(Apps.wallpaperEngine)
	hl.exec_cmd(Apps.steam)
	hl.exec_cmd(Apps.music)
	hl.exec_cmd(Apps.discord)

	-- Window Overview
	hl.exec_cmd("qs -c overview")
end)
