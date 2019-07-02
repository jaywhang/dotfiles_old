# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Name of the theme to load.
ZSH_THEME="ys"

# Disable bi-weekly auto-update checks for oh-my-zsh.
DISABLE_AUTO_UPDATE="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Date format to use in the output of 'history' command.
HIST_STAMPS="yyyy-mm-dd"

# Folder containing custom zsh configurations.
ZSH_CUSTOM=$HOME/.dotfiles/zsh

# List of oh-my-zsh plugins to load.
plugins=(git history-substring-search git-flow-completion docker kubectl)

# mkdir a directory and cd into it.
function mkcd {
  dir="$*";
  mkdir -p "$dir" && cd "$dir";
}

# Load Google-specific zsh configurations.
if [ -f $HOME/.at_google.zsh ]; then
  source $HOME/.at_google.zsh
fi

# Misc configuration.
export EDITOR='vim'
export VISUAL='vim'

# Set various directory aliases.
export XDG_CONFIG_HOME="$HOME/.config"
export DOTFILES="$HOME/.dotfiles"

# Load oh-my-zsh.
source $ZSH/oh-my-zsh.sh

# Load machine-specific settings (should come before sourcing aliases.sh)
if [ -f $HOME/.$HOST"_config.sh" ]; then
  source $HOME/.$HOST"_config.sh"
fi

# Load custom scripts.
export PATH=$DOTFILES/scripts:$PATH
export PATH=~/.diff-so-fancy/:$PATH  # Improved diff tool
export PATH=$HOME/.bin:$PATH

# Default FZF config.
export FZF_DEFAULT_OPTS='--layout=reverse --border --no-height'
# export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="--preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# Load machine-specific settings
if [ -f $HOME/.$HOST"_config.sh" ]; then
  source $HOME/.$HOST"_config.sh"
fi

# Load aliases.
source $DOTFILES/aliases.sh

# Avoid terminal locking up (especially inside Vim) from Ctrl-S (which can be
# unlocked with Ctrl-Q).
stty -ixon

# Load fzf key bindings for zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# For rbenv
eval "$(rbenv init -)"
