alias editAliases='micro ~/.config/zsh/aliases.zsh'

# HYPRLAND
alias editHyprland='micro ~/.config/hypr/hyprland.conf'
alias editHyprlandBase='micro ~/.config/hypr/configs/hyprBase.conf'
alias editHyprMonitors='micro ~/.config/hypr/configs/hyprmonitors.conf'
alias editHyprVars='micro ~/.config/hypr/configs/hyprVars.conf'
alias editHyprWorkspaces='micro ~/.config/hypr/configs/hyprworkspaces.conf'
alias editHyprRules='micro ~/.config/hypr/configs/hyprrules.conf'
alias editHyprLook='micro ~/.config/hypr/configs/hyprlook.conf'
alias editHyprAnimations='micro ~/.config/hypr/configs/hypranimations.conf'
alias editHyprAutostart='micro ~/.config/hypr/configs/hyprautostart.conf'
alias editHyprInput='micro ~/.config/hypr/configs/hyprinput.conf'
alias editHyprApps='micro ~/.config/hypr/configs/hyprapps.conf'
alias editHyprKeyBinds='micro ~/.config/hypr/configs/hyprkeybinds.conf'
alias editHyprLock='micro ~/.config/hypr/hyprlock.conf'

# Other Ricing Stuff
alias editWaybar='micro ~/.config/waybar/config'
alias editWaybarCSS='micro ~/.config/waybar/style.css'
alias editLauncher='micro ~/.config/wofi/style.css'
alias editWallpaper='micro ~/.config/hypr/hyprpaper.conf'
alias editNotification='micro ~/.config/mako/config'
alias editOsFetch='micro ~/.config/fastfetch/config.jsonc'
alias editTerminal='micro ~/.config/kitty/kitty.conf'
alias editShell='micro ~/.config/zsh/.zshrc'

alias reloadWaybar='pkill waybar && waybar & disown'
alias reloadHyprland='hyprctl reload'

# Quality of Life
alias showBinds='cat ~/.config/show/keybinds.txt'
alias editBinds='micro ~/.config/show/keybinds.txt'
alias showCommands='cat ~/.config/show/commands.txt'
alias editCommands='micro ~/.config/show/commands.txt'
alias changeDefaultApps='selectdefaultapplication'
alias clr='clear'
alias osFetch='fastfetch'
alias ls='ls -a'
alias tree='tree -a'
alias reloadShell='clr && source ~/.config/zsh/.zshrc'

alias home='cd ~'

alias startVideo='mpv '
alias openPicture='imv '

alias systemUpdate='arch-update'

alias toolbox='~/jetbrains/jetbrains-toolbox'
alias zen='flatpak run app.zen_browser.zen'
