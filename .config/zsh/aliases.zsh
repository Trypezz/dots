CONFIG="$HOME/.config"

alias editAliases='$EDITOR $CONFIG/zsh/aliases.zsh'

# HYPRLAND
alias editHyprland='$EDITOR $CONFIG/hypr/hyprland.conf'
alias editHyprlandBase='$EDITOR $CONFIG/hypr/configs/base.conf'
alias editmonitors='$EDITOR $CONFIG/hypr/configs/monitors.conf'
alias editvars='$EDITOR $CONFIG/hypr/configs/vars.conf'
alias editworkspaces='$EDITOR $CONFIG/hypr/configs/workspaces.conf'
alias editrules='$EDITOR $CONFIG/hypr/configs/rules.conf'
alias editHyprStyle='$EDITOR $CONFIG/hypr/configs/style.conf'
alias editHyprAnimations='$EDITOR $CONFIG/hypr/configs/animations.conf'
alias editAutostart='$EDITOR $CONFIG/hypr/configs/autostart.conf'
alias editInput='$EDITOR $CONFIG/hypr/configs/input.conf'
alias editApps='$EDITOR $CONFIG/hypr/configs/apps.conf'
alias editBinds='$EDITOR $CONFIG/hypr/configs/binds.conf'
alias editLockscreen='$EDITOR $CONFIG/hypr/hyprlock.conf'
alias editPermissions='$EDITOR $CONFIG/hypr/configs/permissions.conf'

# Other Ricing Stuff
alias editTerminal='$EDITOR $CONFIG/kitty/kitty.conf'
alias editShell='$EDITOR $CONFIG/zsh/.zshrc'
alias editOsFetch='$EDITOR $CONFIG/fastfetch/config.jsonc'

alias editWaybarCSS='$EDITOR $CONFIG/waybar/style.css'
alias editWaybar='$EDITOR $CONFIG/waybar/config.jsonc'
alias editWaybarModules='$EDITOR $CONFIG/waybar/modules.json'

alias editSwayNC='$EDITOR $CONFIG/swaync/config.json'
alias editSwayControlCenter='$EDITOR $CONFIG/swaync/modules/control-center.css'
alias editSwayNotifications='$EDITOR $CONFIG/swaync/modules/notifications.css'

alias editRofi='$EDITOR $CONFIG/rofi/theme.rasi'

alias editThemeSwitcher='$EDITOR $CONFIG/themes/themeMenu.sh'
alias editWallpaperSelector='$EDITOR $CONFIG/bin/wallpaperSelector.sh'

# Quality of Life
alias clr='clear'
alias ls='exa -l'
alias tree='tree -a'
alias reloadShell='clr && source $CONFIG/zsh/.zshrc'
alias refreshShell='clr && source $CONFIG/zsh/.zshrc && titlefetch'

alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'

alias home='cd $HOME'
alias dots='cd dots/.config'

alias getPID='pgrep -af '

alias install='yay -S --noconfirm'
alias uninstall='yay -Rns --noconfirm'

alias startVideo='mpv '
alias openPicture='imv '

alias systemUpdate='arch-update'

# DEV Stuff
alias devC='cd DEV/C'
alias devCS='cd DEV/C#'
alias devJava='cd DEV/Java'
