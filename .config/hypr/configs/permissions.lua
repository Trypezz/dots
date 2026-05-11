-- Permissions Config
-- Never touch again

hl.config({
	ecosystem = {
		enforce_permissions = 1,
	},
})

hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprlock", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/quickshell", "screencopy", "allow")
