CONFIG="$HOME/.config"

alias editAliases='micro $CONFIG/zsh/aliases.zsh'

# HYPRLAND
alias editHyprland='micro $CONFIG/hypr/hyprland.conf'
alias editHyprlandBase='micro $CONFIG/hypr/configs/base.conf'
alias editmonitors='micro $CONFIG/hypr/configs/monitors.conf'
alias editvars='micro $CONFIG/hypr/configs/vars.conf'
alias editworkspaces='micro $CONFIG/hypr/configs/workspaces.conf'
alias editrules='micro $CONFIG/hypr/configs/rules.conf'
alias editHyprStyle='micro $CONFIG/hypr/configs/style.conf'
alias editHyprAnimations='micro $CONFIG/hypr/configs/animations.conf'
alias editAutostart='micro $CONFIG/hypr/configs/autostart.conf'
alias editInput='micro $CONFIG/hypr/configs/input.conf'
alias editApps='micro $CONFIG/hypr/configs/apps.conf'
alias editBinds='micro $CONFIG/hypr/configs/binds.conf'
alias editLockscreen='micro $CONFIG/hypr/hyprlock.conf'
alias editPermissions='micro $CONFIG/hypr/configs/permissions.conf'

# Other Ricing Stuff
alias editTerminal='micro $CONFIG/kitty/kitty.conf'
alias editShell='micro $CONFIG/zsh/.zshrc'
alias editOsFetch='micro $CONFIG/fastfetch/config.jsonc'

alias editWaybarCSS='micro $CONFIG/waybar/style.css'
alias editWaybar='micro $CONFIG/waybar/config.jsonc'
alias editWaybarModules='micro $CONFIG/waybar/modules.json'

alias editSwayNC='micro $CONFIG/swaync/config.json'
alias editSwayControlCenter='micro $CONFIG/swaync/themes/default/control-center.css'
alias editSwayNotifications='micro $CONFIG/swaync/themes/default/notifications.css'

# Quality of Life
alias clr='clear'
alias osFetch='fastfetch'
alias ls='exa -l'
alias tree='tree -a'
alias reloadShell='clr && source $CONFIG/zsh/.zshrc'

alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'

alias home='cd $HOME'

alias startVideo='mpv '
alias openPicture='imv '

alias systemUpdate='arch-update'

# DEV Stuff
alias devC='cd DEV/C'
alias devCS='cd DEV/C#'
alias devJava='cd DEV/Java'
