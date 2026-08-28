# --- Login/Start Info ---
# Fastfetch Fancy Header
# Only one terminal with fastfetch, others empty

if [[ -o interactive \
   && -n "$KITTY_WINDOW_ID" \
   && -x "$HOME/.config/bin/utils/titlefetch.sh" ]]; then

  # Shared Marker-Directory (XDG_RUNTIME_DIR is ideal, points at /tmp)
  local marker_dir="${XDG_RUNTIME_DIR:-/tmp}/kitty_fastfetch_shown"
  mkdir -p "$marker_dir"

  # clean up old/dead markers (Check if process does not exist anymore)
  for f in "$marker_dir"/*(N); do
    [[ -f "$f" ]] || continue
    local pid=${f:t}
    if ! kill -0 "$pid" 2>/dev/null; then
      rm -f "$f"
    fi
  done

  # Check if there is a marker left
  if [[ -z "$(print -l "$marker_dir"/*(N))" ]]; then
    # If no terminal created a marker -> open fastfetch, create marker
    touch "$marker_dir/$$"
    # Remove marker after this terminal was exited
    trap 'rm -f "'"$marker_dir"'/$$"' EXIT
    "$HOME/.config/bin/utils/titlefetch.sh"
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATHS
path_add=(
    "$HOME/.local/bin"
    "/usr/local/bin"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    # Custom Scripts
    "$HOME/.config/bin"
    "$HOME/.config/bin/services"
    "$HOME/.config/bin/UI"
    "$HOME/.config/bin/utils"
    "$HOME/.config/bin/helper"
    "$HOME/Documents/scripts"
)

for dir in "${path_add[@]}"; do
    PATH="$PATH:$dir"
done

export PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"
export VCPKG_ROOT=$HOME/.local/share/vcpkg

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

