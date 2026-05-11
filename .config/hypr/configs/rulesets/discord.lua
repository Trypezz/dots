-- Discord Ruleset

hl.window_rule({
	match = {
		class = "discord",
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
