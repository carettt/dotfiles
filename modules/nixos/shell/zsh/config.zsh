# hooks
eval "$(direnv hook zsh)"
eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/conf.yaml)"

# fast load antidote with static file unless zsh_plugins has been updated
if [[ ! ~/.zsh_plugins.zsh -nt ~/.zsh_plugins.txt ]]; then
  ( 
    echo "bundling plugins..."
    source /run/current-system/sw/share/antidote/antidote.zsh
    antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh
    echo "done !"
  )
fi
source ~/.zsh_plugins.zsh

# binds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# non-native settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# load completions
autoload -U compinit && compinit

# enable zoxide as cd command
eval "$(zoxide init zsh --cmd cd)"

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# aliases
alias t='eza -T --group-directories-first'
alias ls='eza'
alias l='eza -al --group-directories-first'

# functions
source ~/.zsh_functions
