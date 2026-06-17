-- Games Config

require("steam")

-- Just in case of something weird happens
hl.window_rule({
	match = {
		class = "steam_app_%d+",
		title = "^$",
	},
	tag = "-game",
})

require("specialGames")
