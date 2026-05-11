-- Media Ruleset

hl.window_rule({
	match = {
		class = "com.gabm.satty",
	},
	tag = "+viewer",
})

hl.window_rule({
	match = {
		class = "mpv",
	},
	tag = "+viewer",
})

hl.window_rule({
	name = "viewer",
	match = {
		tag = "viewer",
	},
	fullscreen = true,
	no_blur = true,
	opacity = "1.0",
})
