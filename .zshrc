# alias
setopt complete_aliases

LANG=en_US

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

# fzf
alias fzf='fzf --height 70% --reverse'

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
	TARGET=`git branch -r | fzf`
	git checkout -B $TARGET[10,-1] $TARGET[3,-1]
}

# tmux
alias tmux='tmux -u'
tmux source $ZDOTDIR/.tmux.conf
function tmux-get-main-pwd() {
	mainpid=$(tmux list-panes -F '#{pane_pid}' | head -n 1)
	lsof -a -p $mainpid -d cwd -Fn | tail -1 | sed 's/.//'
}
function tmux-on() {
	tmux new-window
	tmux bind r source-file $ZDOTFILE/.tmux.conf
	tmux split-window -h
	tmux split-window
	tmux split-window
}

# docker
alias docker-rm-all='docker ps -f $(docker ps -aq)'

# compinit
autoload -U compinit
compinit

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

SHOBON='(´･ω･`)'
SHAKIN='(`･ω･´)'
#prompt
PROMPT='%(?.%F{cyan}${SHAKIN}.%F{red}${SHOBON})%f %B%F{green}%n%f%b:%B%F{blue}%~%f%b [${vcs_info_msg_0_}] 
$ '
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

# bindkey
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey -v

# fhist
fhsave() {
	$(fhist save $BUFFER)
	zle accept-line
}
zle -N fhsave
bindkey "^M" fhsave

fhsearchquery() {
	ARG0=$(echo $BUFFER | awk '{print $1}')
	QUERY=$(echo $LBUFFER | awk '{print $NF}')
	CMD=$(echo $LBUFFER | awk '{$NF=""; print $0}')
	LBUFFER+=$(fhist list $ARG0 | fzf -q $QUERY)
	RBUFFER=""
	zle clear-screen
}
zle -N fhsearchquery
bindkey "^p" fhsearchquery

fhsearch() {
	ARG0=$(echo $BUFFER | awk '{print $1}')
	LBUFFER+=$(fhist list $ARG0 | fzf)
	RBUFFER=""
	zle clear-screen
}
zle -N fhsearch
#bindkey "^O" fhsearch

# auto_cd
setopt auto_cd
setopt auto_pushd

#predict
autoload predict-on
predict-on

# plugin
source `ghq root`/github.com/b4b4r07/enhancd/init.sh
ENHANCD_FILTER=fzy:fzf:peco
export ENHANCD_FILTER

#local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
