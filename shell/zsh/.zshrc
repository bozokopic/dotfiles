HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

export GPG_TTY=$(tty)

bindkey -v

fpath=(~/.dotfiles/shell/zsh/tabcompletion $fpath)
autoload -Uz compinit
compinit

. ~/.dotfiles/shell/zsh/zsh-git-prompt/zshrc.sh
PROMPT='[%F{green}%n%f@%m %F{green}%~%f $(git_super_status)]$ '

[ -n "$(command -v fzf)" ] && . ~/.dotfiles/shell/zsh/fzf/key-bindings.zsh

[ -n "$(command -v broot)" ] && . ~/.dotfiles/shell/zsh/broot.zsh

SYSTEM_PLUGINS=(/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
                /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
                /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh)
for plugin in $SYSTEM_PLUGINS; do
    [ -e "$plugin" ] && . $plugin
done

bindkey '\e[1~'       beginning-of-line                 # Home
bindkey '\e[4~'       end-of-line                       # End
bindkey '\e[3~'       delete-char                       # Delete
[ -n "$(command -v history-substring-search-up)" ] && \
    bindkey '^[[A'    history-substring-search-up       # Up
[ -n "$(command -v history-substring-search-down)" ] && \
    bindkey '^[[B'    history-substring-search-down     # Down

bindkey '^[[1;5D' backward-word                     # Ctrl+Left
bindkey '^[[1;5C' forward-word                      # Ctrl+Right
