autoload -Uz compinit
compinit

setopt AUTO_LIST
setopt AUTO_MENU
setopt COMPLETE_IN_WORD

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'