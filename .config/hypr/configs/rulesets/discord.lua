-- Discord/Vesktop Ruleset

hl.window_rule({
	match = {
		class = "^(vesktop.*|discord.*)",
	},
	tag = "+messenger",
})

hl.window_rule({
	name = "messenger",
	match = {
		tag = "messenger",
	},
	workspace = "3 silent",
})

hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = {
		class = "xwaylandvideobridge",
	},
	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	opacity = 0.0,
})
