#compinit
autoload -U compinit
compinit

#prompt
PROMPT='%B%F{green}%n@%m%f%b:%B%F{blue}%~%f%b$ '
PROMPT2='%B%F{green}%_%f%b> '

# hist
HISTFILE=$ZDOTDIR/.zsh_hist
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_dups
setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# bindkey -v
bindkey -v

# auto_cd
setopt auto_cd
setopt auto_pushd

#predict
autoload predict-on
predict-on

# ls alias
alias ll='ls -la --color=auto'
