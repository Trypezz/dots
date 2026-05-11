-- Layer Ruleset

hl.layer_rule({
	match = {
		namespace = "waybar",
	},
	animation = "slide top",
})

hl.layer_rule({
	match = {
		namespace = "swaync-control-center",
	},
	animation = "slide right",
})

hl.layer_rule({
	match = {
		namespace = "swaync-notification-window",
	},
	animation = "slide right",
})

hl.layer_rule({
	match = {
		namespace = "swww-daemon",
	},
	animation = "fade",
})

hl.layer_rule({
	match = {
		namespace = "mpvpaper",
	},
	animation = "fade",
})

hl.layer_rule({
	match = {
		namespace = "logout_dialog",
	},
	animation = "slide bottom",
})

hl.layer_rule({
	match = {
		namespace = "rofi",
	},
	animation = "slide top",
})
