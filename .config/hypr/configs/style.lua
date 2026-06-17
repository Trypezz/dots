-- Style Config (Dynamic)

hl.config({
	general = {
		gaps_in = Theme.gapsIn,
		gaps_out = Theme.gapsOut,
		border_size = Theme.borderSize,
		col = {
			active_border = { colors = { Theme.primaryColor, Theme.primaryColorSolid }, angle = 45 },
			inactive_border = Theme.secondaryColor,
		},
		layout = "dwindle",
		resize_on_border = false,
		allow_tearing = false,
		snap = {
			enabled = true,
		},
	},
	decoration = {
		rounding = Theme.borderRadius,
		rounding_power = Theme.borderRadiusPower,
		active_opacity = Theme.activeTransparency,
		inactive_opacity = Theme.inactiveTransparency,
		fullscreen_opacity = Theme.fullscreenTransparency,
		shadow = {
			enabled = true,
			range = Theme.shadowRange,
			render_power = Theme.shadowPower,
			color = Theme.shadowColor,
		},
		blur = {
			enabled = true,
			size = Theme.blurSize,
			passes = Theme.blurPasses,
			new_optimizations = true,
			xray = false,
		},
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = false,
	},
})
