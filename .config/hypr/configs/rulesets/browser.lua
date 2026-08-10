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
	move = "(monitor_w-window_w-monitor_w*0.13) (monitor_h-window_h-monitor_h*0.39)",
	size = "(monitor_w*0.5) (monitor_h*0.5)",
})
