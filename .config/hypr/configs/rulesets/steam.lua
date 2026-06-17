-- Steam config

hl.window_rule({
	match = {
		class = "steam_app_%d+",
	},
	tag = "+game",
})

hl.window_rule({
	name = "steam",
	match = {
		class = "steam",
		title = "Steam",
	},
	workspace = "4 silent",
})

hl.window_rule({
	name = "steam-stuff",
	match = {
		class = "steam",
		title = "Launching.*",
	},
	float = true,
	center = true,
	workspace = "1",
})

-- Games
hl.window_rule({
	name = "game",
	match = {
		tag = "game",
	},
	workspace = "1",
	no_blur = true,
	opacity = "1.0",
	fullscreen = true,
	float = false,
})
