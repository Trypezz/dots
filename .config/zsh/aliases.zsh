alias editAliases='micro $HOME/.config/zsh/aliases.zsh'

# HYPRLAND
alias editHyprland='micro $HOME/.config/hypr/hyprland.conf'
alias editHyprlandBase='micro $HOME/.config/hypr/configs/hyprBase.conf'
alias editHyprMonitors='micro $HOME/.config/hypr/configs/hyprmonitors.conf'
alias editHyprVars='micro $HOME/.config/hypr/configs/hyprVars.conf'
alias editHyprWorkspaces='micro $HOME/.config/hypr/configs/hyprworkspaces.conf'
alias editHyprRules='micro $HOME/.config/hypr/configs/hyprrules.conf'
alias editHyprLook='micro $HOME/.config/hypr/configs/hyprlook.conf'
alias editHyprAnimations='micro $HOME/.config/hypr/configs/hypranimations.conf'
alias editHyprAutostart='micro $HOME/.config/hypr/configs/hyprautostart.conf'
alias editHyprInput='micro $HOME/.config/hypr/configs/hyprinput.conf'
alias editHyprApps='micro $HOME/.config/hypr/configs/hyprapps.conf'
alias editHyprKeyBinds='micro $HOME/.config/hypr/configs/hyprkeybinds.conf'
alias editHyprLock='micro $HOME/.config/hypr/hyprlock.conf'

# Other Ricing Stuff
alias editWaybar='micro $HOME/.config/waybar/config'
alias editWaybarCSS='micro $HOME/.config/waybar/style.css'
alias editLauncher='micro $HOME/.config/wofi/style.css'
alias editWallpaper='micro $HOME/.config/hypr/hyprpaper.conf'
alias editNotification='micro $HOME/.config/mako/config'
alias editOsFetch='micro $HOME/.config/fastfetch/config.jsonc'
alias editTerminal='micro $HOME/.config/kitty/kitty.conf'
alias editShell='micro $HOME/.config/zsh/.zshrc'

alias reloadWaybar='pkill waybar && waybar & disown'
alias reloadHyprland='hyprctl reload'

# Quality of Life
alias showBinds='cat $HOME/.config/show/keybinds.txt'
alias editBinds='micro $HOME/.config/show/keybinds.txt'
alias showCommands='cat $HOME/.config/show/commands.txt'
alias editCommands='micro $HOME/.config/show/commands.txt'
alias changeDefaultApps='selectdefaultapplication'
alias clr='clear'
alias osFetch='fastfetch'
alias ls='ls -a'
alias tree='tree -a'
alias reloadShell='clr && source $HOME/.config/zsh/.zshrc'

alias home='cd ~'

alias startVideo='mpv '
alias openPicture='imv '

alias systemUpdate='arch-update'

alias toolbox='$HOME/jetbrains/jetbrains-toolbox'
alias zen='flatpak run app.zen_browser.zen'
