-- Base Config
-- Never touch again

require("configs.permissions")

hl.config({
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
})

-- Basic Window Rules
hl.window_rule({
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	match = {
		class = "hyprland-run",
	},
	move = "20 monitor_h-120",
	float = true,
})
