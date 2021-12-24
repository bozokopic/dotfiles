HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

export GPG_TTY=$(tty)

bindkey -v

autoload -Uz compinit
compinit

. ~/.dotfiles/shell/zsh/zsh-git-prompt/zshrc.sh
PROMPT='[%F{green}%n%f@%m %F{green}%~%f $(git_super_status)]$ '

. ~/.dotfiles/shell/zsh/fzf/key-bindings.zsh

. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '\e[1~'   beginning-of-line                 # Home
bindkey '\e[4~'   end-of-line                       # End
bindkey '\e[3~'   delete-char                       # Delete
bindkey '^[[A'    history-substring-search-up       # Up
bindkey '^[[B'    history-substring-search-down     # Down

bindkey '^[[1;5D' backward-word                     # Ctrl+Left
bindkey '^[[1;5C' forward-word                      # Ctrl+Right
