HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

bindkey -v

autoload -Uz compinit
compinit

. ~/.dotfiles/shell/zsh/zsh-git-prompt/zshrc.sh

PROMPT='[%F{green}%n%f@%m %F{green}%~%f $(git_super_status)]$ '
