-- Prism Launcher
hl.window_rule({
	name = "prism",
	match = {
		title = "Prism Launcher.*",
	},
	workspace = "6",
	no_blur = true,
	opacity = "1.0",
})

-- Minecraft
hl.window_rule({
	name = "minecraft",
	match = {
		title = "^(Minecraft.*|COBBLEVERSE.*)",
	},
	workspace = "1",
	no_blur = true,
	opacity = "1.0",
	fullscreen = true,
	float = false,
})

-- P5X
hl.window_rule({
	match = {
		class = "steam_app_%d+",
		title = "P5XGame",
	},
	tag = "-game",
})

hl.window_rule({
	name = "p5x",
	match = {
		class = "steam_app_%d+",
		title = "P5XGame",
	},
	float = true,
	center = true,
	tag = "-game",
	workspace = "1",
})

-- WeMod
hl.window_rule({
	match = {
		class = "steam_app_%d+",
		title = "WeMod",
	},
	tag = "-game",
})

hl.window_rule({
	name = "wemod",
	match = {
		class = "steam_app_%d+",
		title = "WeMod",
	},
	float = true,
	center = true,
	fullscreen = false,
	size = "(monitor_w*0.75) (monitor_h*0.75)",
	tag = "-game",
	workspace = "5 silent",
})

-- Heroic (float except Mainwindow)
hl.window_rule({
	match = {
		class = "heroic",
		title = "negative:Heroic Games Launcher",
	},
	float = true,
})
