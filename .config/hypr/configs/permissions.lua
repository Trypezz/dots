-- Permissions Config
-- Never touch again

hl.config({
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
		enforce_permissions = 1,
	},
})

hl.permission({
	binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland",
	type = "screencopy",
	mode = "allow",
})

hl.permission({
	binary = "/usr/(bin|local/bin)/hyprlock",
	type = "screencopy",
	mode = "allow",
})

hl.permission({
	binary = "/usr/(lib|libexec|lib64)/grim",
	type = "screencopy",
	mode = "allow",
})

hl.permission({
	binary = "/usr/(bin|local/bin)/hyprshot",
	type = "screencopy",
	mode = "allow",
})
