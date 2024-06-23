zsh_plugins=~/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  ( 
    echo "bundling plugins..."
    source /run/current-system/sw/share/antidote/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
    echo "done !"
  )
fi
source ${zsh_plugins}.zsh

eval "$(fzf --zsh)"
eval "$(direnv hook zsh)"

bindkey -M vicmd '^p' history-search-backward
bindkey -M vicmd '^n' history-search-forward
bindkey -M viins '^p' history-search-backward
bindkey -M viins '^n' history-search-forward

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

autoload -U compinit && compinit
