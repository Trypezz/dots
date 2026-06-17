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

alias install='yay -S'
alias uninstall='yay -Rns'
alias uninstallIgnDep='yay -Rdd'

alias systemUpdate='arch-update'
alias showSwap='swapon --show'

# Due to current AUR state
alias malwareCheck='bash <(curl -s https://cscs.pastes.sh/raw/aurvulntest20260611.sh) && echo "Affected Packages Found:"; comm -12 <(pacman -Qq | sort) <(curl -s https://cscs.pastes.sh/raw/aurvulnlist20260611.txt | sort) | { read -r l && printf '%s\n' "$l" || echo "None. No known compromised packages are installed."; }'


# DEV Stuff
alias devC='cd DEV/C'
alias devCS='cd DEV/CSharp'
alias devJava='cd DEV/Java'
alias devCpp='cd DEV/cpp'

