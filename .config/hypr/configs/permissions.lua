-- Permissions Config
-- Never touch again

hl.config({
	ecosystem = {
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
	binary = "/usr/(bin|local/bin)/quickshell",
	type = "screencopy",
	mode = "allow",
})
