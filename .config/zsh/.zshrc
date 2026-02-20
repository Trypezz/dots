# --- Login/Start Info ---
# Fastfetch Fancy Header
# Only on new Kitty Windows
if [[ -o interactive \
   && -n "$KITTY_WINDOW_ID" \
   && -z "$__KITTY_FASTFETCH_SHOWN" \
   && -x "$HOME/.config/bin/utils/titlefetch.sh" ]]; then

  export __KITTY_FASTFETCH_SHOWN=1
  "$HOME/.config/bin/utils/titlefetch.sh"

fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATHS
path_add=(
    "$HOME/bin"
    "$HOME/.local/bin"
    "/usr/local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.config/bin"
    "$HOME/.config/bin/services"
    "$HOME/.config/bin/UI"
    "$HOME/.config/bin/utils"
)

for dir in "${path_add[@]}"; do
    PATH="$PATH:$dir"
done

export PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
COMPLETION_WAITING_DOTS="true"

# Change the command execution time
HIST_STAMPS="dd.mm.yyyy"

plugins=(
  git
  sudo
  web-search
  archlinux
  copyfile
  copybuffer
  dirhistory
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source "/usr/share/nvm/init-nvm.sh"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source "$HOME/.config/zsh/aliases.zsh"

if [[ -f "$HOME/.config/zsh/env.sh" ]]; then
    source "$HOME/.config/zsh/env.sh"
fi

