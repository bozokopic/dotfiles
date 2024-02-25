HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

export GPG_TTY=$(tty)

bindkey -v

# fpath=(~/.dotfiles/shell/zsh/tabcompletion
#        $fpath)
# autoload -Uz compinit
# compinit

setopt PROMPT_SUBST
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_STATESEPARATOR='|'
. ~/.dotfiles/shell/git-prompt.sh
PROMPT='[%F{green}%n%f@%m %F{green}%~%f$(__git_ps1 " (%s)")]$ '

[ -n "$(command -v fzf)" ] && . ~/.dotfiles/shell/zsh/fzf/key-bindings.zsh

[ -n "$(command -v broot)" ] && . ~/.dotfiles/shell/zsh/broot.zsh

[ -n "$(command -v direnv)" ] && eval "$(direnv hook zsh)"

SYSTEM_PLUGINS=(zsh-autosuggestions
                zsh-syntax-highlighting
                zsh-history-substring-search)
SYSTEM_PLUGINS_DIR=/usr/share/zsh/plugins
for plugin in $SYSTEM_PLUGINS; do
    [ -e "$SYSTEM_PLUGINS_DIR/$plugin/$plugin.zsh" ] && \
        . $SYSTEM_PLUGINS_DIR/$plugin/$plugin.zsh
done

bindkey '\e[1~'       beginning-of-line                 # Home
bindkey '\e[4~'       end-of-line                       # End
bindkey '\e[3~'       delete-char                       # Delete

if [ -f $SYSTEM_PLUGINS_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    bindkey '^[[A'    history-substring-search-up       # Up
    bindkey '^[[B'    history-substring-search-down     # Down
fi

bindkey '^[[1;5D' backward-word                     # Ctrl+Left
bindkey '^[[1;5C' forward-word                      # Ctrl+Right
