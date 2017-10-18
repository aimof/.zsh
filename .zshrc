# alias
setopt complete_aliases

case ${OSTYPE} in
	darwin*)
		alias ls='ls -G'
	;;
	linux*)
		alias ls='ls --color'
	;;
esac
alias ll='ls -la'
alias la='ls -a'
alias lf='ls -F'

# alias vim
alias vim='vim -u $HOME/.vim/.vimrc'

# gcd
gcd() {
	TARGET=`gcdpath $1`
	gcdhist add $TARGET
	cd $TARGET
	ls $TARGET
}

gcds() {
	TARGET=$(gcdhist latest | fzf)
	gcdhist add $TARGET
	cd $TARGET
	ls $TARGET
}

# git
git-checkout-s() {
	TARGET=`git branch | fzf`
	git checkout $TARGET[3,-1]
}

git-checkout-rs() {
	TARGET=`git branch -a | fzf`
	git checkout -B $TARGET[18,-1] $TARGET[3,-1]
}

# docker
alias docker-rm-all='docker ps -f $(docker ps -aq)'

# compinit
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

#local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
