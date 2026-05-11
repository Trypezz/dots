-- Filebrowser Ruleset

hl.window_rule({
	match = {
		class = "org.gnome.Nautilus",
	},
	tag = "+filebrowser",
})

hl.window_rule({
	name = "files",
	match = {
		tag = "filebrowser",
	},
	opacity = "0.90",
	no_blur = true,
})
