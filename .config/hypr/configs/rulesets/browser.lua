-- Browser Ruleset

hl.window_rule({
	name = "browser",
	match = {
		class = "zen",
	},
	workspace = "2",
})

-- Picture-in-Picture
hl.window_rule({
	match = {
		title = "Picture-in-Picture",
	},
	tag = "+pip",
})

hl.window_rule({
	name = "PiP",
	match = {
		tag = "pip",
	},
	workspace = "3",
	keep_aspect_ratio = true,
	float = true,
	pin = true,
	size = "(monitor_w*0.45) (monitor_h*0.45)",
	move = "(monitor_w*0.525) (monitor_h*0.055)",
})
