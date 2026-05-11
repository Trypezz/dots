-- Spotify Ruleset

hl.window_rule({
	match = {
		class = "Spotify",
	},
	tag = "+music",
})

hl.window_rule({
	name = "music",
	match = {
		tag = "music",
	},
	workspace = "5 silent",
})
