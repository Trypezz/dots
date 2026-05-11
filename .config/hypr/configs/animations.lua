-- Animations Config

hl.config({
	animations = {
		enabled = true,

		bezier = {
			{ name = "smoothOut", x0 = 0.36, y0 = 0, x1 = 0.66, y1 = -0.56 },
			{ name = "smoothIn", x0 = 0.65, y0 = 0.05, x1 = 0.36, y1 = 1 },
			{ name = "overshot", x0 = 0, y0 = 0, x1 = 1, y1 = 1 },
			{ name = "softSnap", x0 = 0.5, y0 = 0.5, x1 = 0.75, y1 = 1 },
			{ name = "fluent", x0 = 0.15, y0 = 0, x1 = 0.1, y1 = 1 },
		},

		animation = {
			{ name = "windows", enabled = true, speed = 1, bezier = "overshot", style = "popin 80%" },
			{ name = "windowsIn", enabled = true, speed = 1, bezier = "overshot", style = "popin 80%" },
			{ name = "windowsOut", enabled = true, speed = 1, bezier = "smoothOut", style = "popin 95%" },
			{ name = "windowsMove", enabled = true, speed = 1, bezier = "softSnap" },
			{ name = "layersIn", enabled = true, speed = 1, bezier = "smoothIn" },
			{ name = "layersOut", enabled = true, speed = 1, bezier = "softSnap" },
			{ name = "fade", enabled = true, speed = 1, bezier = "smoothIn" },
			{ name = "fadeIn", enabled = true, speed = 1, bezier = "smoothIn" },
			{ name = "fadeOut", enabled = true, speed = 1, bezier = "smoothOut" },
			{ name = "fadeSwitch", enabled = true, speed = 1, bezier = "smoothIn" },
			{ name = "fadeShadow", enabled = true, speed = 1, bezier = "smoothIn" },
			{ name = "fadeDim", enabled = true, speed = 1, bezier = "smoothIn" },
			{ name = "fadeDpms", enabled = true, speed = 1, bezier = "smoothIn" },
			{ name = "workspaces", enabled = true, speed = 1, bezier = "overshot", style = "slidefade 30%" },
			{ name = "specialWorkspace", enabled = true, speed = 1, bezier = "overshot", style = "slidefadevert 30%" },
		},
	},
})
