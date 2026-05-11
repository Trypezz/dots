-- Keybinds Config

-- App Starts
hl.bind("SUPER + Q", hl.dsp.exec_cmd(Apps.terminal .. " --title 'Kitty Terminal'"))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd(Apps.filemanager))
hl.bind("SUPER + E", hl.dsp.exec_cmd(Apps.terminal .. " --title 'File Explorer' yazi"))
hl.bind("SUPER + R", hl.dsp.exec_cmd(Apps.appmenu))
hl.bind("SUPER + Z", hl.dsp.exec_cmd(Apps.browser))
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd(Apps.music))
hl.bind("SUPER + M", hl.dsp.exec_cmd(Apps.terminal .. " --title 'Music Player' kew"))
hl.bind("SUPER + CTRL + M", hl.dsp.exec_cmd(Apps.terminal .. " --title 'Visualizer' cava"))
hl.bind("SUPER + S", hl.dsp.exec_cmd(Apps.steam))
hl.bind("SUPER + D", hl.dsp.exec_cmd(Apps.discord))
hl.bind("SUPER + I", hl.dsp.exec_cmd(Apps.settings))
hl.bind("SUPER + SHIFT + U", hl.dsp.exec_cmd(Apps.terminal .. " --title 'System Update' arch-update"))

-- Window Overview
hl.bind("SUPER + TAB", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))

-- Notifications
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind("SUPER + CTRL + N", hl.dsp.exec_cmd("swaync-client -d -sw"))

-- Misc
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd(Apps.terminal .. " --title 'Time & Date' clock-rs"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/bin/helper/reloadDesktop.sh"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/bin/utils/editConfig"))

-- Notes
hl.bind("SUPER + N", hl.dsp.exec_cmd(Apps.terminal .. " --class notes -e " .. Apps.editor))

-- Emergency Terminal
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd(Apps.terminal .. " --title 'EMERGENCY TERMINAL' --class eTerm"))

-- Basic Window Management
hl.bind("SUPER + K", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + K", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("wlogout"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

if hl.get_config("general.layout") == "dwindle" then
	hl.bind("SUPER + J", hl.dsp.layout("togglesplit")) -- dwindle only
end

-- Focus
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

-- Swap
hl.bind("SUPER + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output --raw | satty --filename -"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region --raw | satty --filename -"))

-- Themes
hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd(Apps.themeSwitcher))
hl.bind("SUPER + SHIFT + BACKSPACE", hl.dsp.exec_cmd(Apps.wallpaperSelector))

-- Media Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Mouse Window Management
hl.bind("SUPER" .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER" .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspaces 1-10
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("SUPER" .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER" .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
