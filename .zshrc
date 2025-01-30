############################### INITIALIZATION ###############################

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


############################### Package MANGER ################################


ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export FZF_TMUX=1

zinit light zsh-users/zsh-syntax-highlighting #Highliter

# Lazy load plugins without messages
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# OMZ plugins with silent loading
zinit ice wait'0' silent
zinit snippet OMZP::git
zinit ice wait'0' silent
zinit snippet OMZP::sudo

# Load completions
autoload -Uz compinit && compinit -C
zinit cdreplay -q #In docs it says its necessary

#Keybinds related to that
bindkey -e
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
export FZF_DEFAULT_OPTS="--bind 'ctrl-y:accept'"
bindkey '^[[1;5D' backward-word # Bind Ctrl + Left Arrow to move one word backward
bindkey '^[[1;5C' forward-word # Bind Ctrl + Right Arrow to move one word forward

#completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

#Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

######################################## ALIAS ##########################################
#---- Basic Utilities -----#
alias ls='ls --color'
alias ll='ls -la'
alias lf='yazi'
alias c='clear'
alias d='pwd'
alias file='yazi'
# alias xcopy='xclip -selection clipboard'

#----- Directory navigation shortcuts ------#
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

#---- Laptop functions -----#
alias power='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage'  #Battery %age Shortcuts
alias perc='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage' #Battery %age Shortcuts
alias %age='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage' #Battery %age Shortcuts
alias percentage='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage' #Battery %age Shortcuts
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage' #Battery %age Shortcuts
alias brightness='sudo tee /sys/class/backlight/intel_backlight/brightness <<<' #Brightness control
alias userkey='screenkey'
alias touchpad='hyprctl keyword "device[elan06fa:00-04f3:31be-touchpad]:enabled"'
alias treenode='tree -I node_modules/'

#---- My special Shortcuts -----#
alias i3rwallpaper="~/scripts/i3_random_wallpapers.sh" #Wallpaper randomizer script
alias rwallpaper="~/scripts/change_wallpapers.sh"
alias menubar='gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar' #Set True or False for menubar/Topbar
alias gapsDisable='~/scripts/gaps_rounding_disable.sh'
alias gapsEnable='~/scripts/gaps_rounding_enable.sh'
alias currentWallpaper='~/scripts/current_wallpaper.sh'
alias deleteCurrentWallpaper='~/scripts/deleteCurrentWallpaper.sh'
alias copy='wl-copy'
alias clock='tty-clock -t -C'

#---- Vim related ----#
alias vimbegood='sudo docker run -it --rm brandoncc/vim-be-good:latest'
alias vp='nvim ~/Documents/projects/'
alias vim='nvim' #Vim will open Nvim-
alias v='nvim .'
alias vi='nvim'
alias sv='sudo -E nvim .'
alias snvim='sudo -E nvim .'
alias svim='sudo -E nvim .'
alias sudonvim='sudo -E nvim '
alias sn='sudo -E nvim '
alias pd='pnpm dev'
############################## FUNCTIONAL SHORTCUTS ##################################
#Git SSH copy and see
function gssh() { gh repo view "$1" --json sshUrl }
gcssh() {
  gh repo view "$1" --json sshUrl | jq -r '.sshUrl' | wl-copy
  echo "SSH URL copied to clipboard."
}
#Git input directly ssh
function gitty() {
  if [[ -z "$1" ]]; then
    echo "Please provide a repository name."
  else
    git remote add origin "git@github.com:Barmanji/$1.git"
    echo "Remote origin added for repository: $1"
  fi
}
# function gilly() {
#   if [[ -z "$1" ]]; then
#     echo "Please provide a repository name."
#   else
#     git remote add origin "git@gitlab.com:barmanji/$1.git"
#     echo "Remote origin added for repository: $1"
#   fi
# }

#### DEFAULT EXPORTS #####
export EDITOR=nvim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

