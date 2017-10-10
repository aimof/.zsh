#! /bin/zsh

# ZDOTDIR settings
#if [ ${ZDOTDIR} = '' ]; then
#	echo 'export ZDOTDIR=$HOME/.zsh' >$HOME/.zshenv \
#	&& source $HOME/.zshenv
#fi

# go is required


# define GOPATH
#if [ ${GOPATH} = '' ]; then
#	GOPATH=$HOME/go
#fi

# install ghq
#go get -u github.com/motemen/ghq
#go install gihtub.com/motemen/ghq

# install peco
#go get -u github.com/peco/peco/cmd/peco
#go install github.com/peco/peco/cmd/peco

#install fzf
#go get -u github.com/junegunn/fzf
#go install github.com/junegunn/fzf

# vim
# vim is required

# vim-plug
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vim plug go
#vim +PlugInstall +q +q
#vim +GoInstallBinaries +q +q
