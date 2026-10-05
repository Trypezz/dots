-- Rules for Retro Gaming

hl.window_rule({
	name = "Retro-Arch",
	match = {
		class = "com.libretro.RetroArch",
	},
	tag = "+retro",
})

hl.window_rule({
	name = "retro",
	match = {
		tag = "retro",
	},
	workspace = "1",
	no_blur = true,
	opacity = "1.0",
	fullscreen = true,
	float = false,
})
