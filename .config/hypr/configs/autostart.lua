-- Autostart Config

hl.on("hyprland.start", function()
	hl.exec_cmd(Service.polkitagent)
	hl.exec_cmd(Service.sessionTarget) -- Needed for screenshare (if not using uwsm)
	hl.exec_cmd(Service.portal)
	hl.exec_cmd(Service.archUpdate)
	hl.exec_cmd(Service.notificationCenter)
	hl.exec_cmd(Service.spotifyNotifications)
	hl.exec_cmd(Service.bar)
	hl.exec_cmd(Service.wallpaperEngine)
	hl.exec_cmd(Apps.steam)
	hl.exec_cmd(Apps.spotify)
	hl.exec_cmd(Apps.discord)

	-- Window Overview
	hl.exec_cmd(Service.startOverview)
end)
