-- Settings Ruleset

hl.window_rule({
	match = {
		class = "nwg-displays",
	},
	tag = "+settings",
})

hl.window_rule({
	match = {
		class = "nwg-look",
	},
	tag = "+settings",
})

hl.window_rule({
	match = {
		class = "org.pulseaudio.pavucontrol",
	},
	tag = "+settings",
})

hl.window_rule({
	name = "settings",
	match = {
		tag = "settings",
	},
	float = true,
	center = true,
	size = "(monitor_w*0.75) (monitor_h*0.75)",
})
