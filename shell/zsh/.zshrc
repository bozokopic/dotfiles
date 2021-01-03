HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

bindkey -v

autoload -Uz compinit
compinit

. ~/.dotfiles/shell/zsh/zsh-git-prompt/zshrc.sh
PROMPT='[%F{green}%n%f@%m %F{green}%~%f $(git_super_status)]$ '

. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down