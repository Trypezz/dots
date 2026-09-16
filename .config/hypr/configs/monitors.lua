-- Monitor Config

-- Main
hl.monitor({
	output = "DP-3",
	mode = "highrr",
	position = "2560x0",
	scale = "1",
	--bitdepth = 10,
	--cm = "wide",
	supports_wide_color = 1,
	supports_hdr = 1,
})

-- Secondary
hl.monitor({
	output = "DP-1",
	mode = "highrr",
	position = "0x0",
	scale = "1",
	--bitdepth = 10,
	--cm = "wide",
	supports_wide_color = 1,
	supports_hdr = 1,
})

-- Global settings
hl.config({
	render = {
		cm_enabled = true,
		cm_auto_hdr = 2,
		cm_sdr_eotf = "gamma22",
		direct_scanout = 0,
	},
})
