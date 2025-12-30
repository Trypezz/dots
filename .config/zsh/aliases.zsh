alias editAliases='micro $HOME/.config/zsh/aliases.zsh'

# HYPRLAND
alias editHyprland='micro $HOME/.config/hypr/hyprland.conf'
alias editHyprlandBase='micro $HOME/.config/hypr/configs/base.conf'
alias editmonitors='micro $HOME/.config/hypr/configs/monitors.conf'
alias editvars='micro $HOME/.config/hypr/configs/vars.conf'
alias editworkspaces='micro $HOME/.config/hypr/configs/workspaces.conf'
alias editrules='micro $HOME/.config/hypr/configs/rules.conf'
alias editHyprStyle='micro $HOME/.config/hypr/configs/style.conf'
alias editHyprAnimations='micro $HOME/.config/hypr/configs/animations.conf'
alias editAutostart='micro $HOME/.config/hypr/configs/autostart.conf'
alias editInput='micro $HOME/.config/hypr/configs/input.conf'
alias editApps='micro $HOME/.config/hypr/configs/apps.conf'
alias editBinds='micro $HOME/.config/hypr/configs/binds.conf'
alias editLockscreen='micro $HOME/.config/hypr/hyprlock.conf'

# Other Ricing Stuff
alias editWaybarCSS='micro $HOME/.config/waybar/style.css'
alias editOsFetch='micro $HOME/.config/fastfetch/config.jsonc'
alias editTerminal='micro $HOME/.config/kitty/kitty.conf'
alias editShell='micro $HOME/.config/zsh/.zshrc'

alias reloadHyprland='hyprctl reload'

# Quality of Life
alias clr='clear'
alias osFetch='fastfetch'
alias ls='exa -l'
alias tree='tree -a'
alias reloadShell='clr && source $HOME/.config/zsh/.zshrc'

alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'

alias home='cd $HOME'

alias startVideo='mpv '
alias openPicture='imv '

alias systemUpdate='arch-update'

# DEV Stuff
alias devC='cd DEV/C'
alias devCS='cd DEV/C#'
alias devJava='cd DEV/Java'
