CONFIG="$HOME/.config"

alias editAliases='$EDITOR $CONFIG/zsh/aliases.zsh'

# Other Ricing Stuff
alias editTerminal='$EDITOR $CONFIG/kitty/kitty.conf'
alias editShell='$EDITOR $CONFIG/zsh/.zshrc'
alias editOsFetch='$EDITOR $CONFIG/fastfetch/config.jsonc'

# Quality of Life
alias clr='clear'
alias ls='exa -l'
alias tree='tree -a'
alias reloadShell='clr && source $CONFIG/zsh/.zshrc'
alias refreshShell='clr && source $CONFIG/zsh/.zshrc && titlefetch.sh'

alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'

alias home='cd $HOME'
alias config='cd .config'
alias dots='cd dots/.config'

alias getPID='pgrep -af '

alias install='yay -S --noconfirm'
alias uninstall='yay -Rns --noconfirm'

alias systemUpdate='arch-update'

# DEV Stuff
alias devC='cd DEV/C'
alias devCS='cd DEV/CSharp'
alias devJava='cd DEV/Java'
