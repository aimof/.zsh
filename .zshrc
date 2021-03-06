# alias
#setopt complete_aliases

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

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
alias zshrc='nvim $ZDOTDIR/.zshrc'
alias vimrc='nvim $HOME/.config/nvim/init.vim'
alias gorc='nvim $HOME/.config/nvim/ftplugin/go.vim'

# fzf
alias FZF_DEFAULT_OPTS='--height 70% --reverse'


# tmux
if hash tmux &>/dev/null; then
	function ts() {
		tmux source $ZDOTDIR/.tmux.conf
		tmux rename-window name
		tmux split-window -h
		tmux split-window -v -t name.1
		tmux select-pane -t name.0
		clear
	}
	function tmux-get-main-pwd() {
		mainpid=$(tmux list-panes -F '#{pane_pid}' | head -n 1)
		lsof -a -p $mainpid -d cwd -Fn | tail -1 | sed 's/.//'
	}
fi


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

SHOBON=$'\(´･ω･\`%)'
SHAKIN=$'\(\`･ω･´%)'
#prompt
PROMPT='%(?.%F{cyan}$SHAKIN.%F{red}$SHOBON) %f %B%F{green}%n@%M%f%b: (%F{blue}%D %*%f) [${vcs_info_msg_0_}]
%B%F{blue}%~%f%b $ '
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
bindkey -v

# auto_cd
setopt auto_cd
setopt auto_pushd

#predict
#autoload predict-on
#predict-on

# plugin
source `ghq root`/github.com/b4b4r07/enhancd/init.sh
ENHANCD_FILTER=fzy:fzf:peco
export ENHANCD_FILTER
export ENHANCD_DIR=$HOME/.zsh/.enhancd

#local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

#my-predict
my-predict() {
	BUFFER=`history -n -r 1 | sort | uniq | fzf --query=$LBUFFER`
	return 0
}

zle -N my-predict

bindkey "^P" my-predict

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
