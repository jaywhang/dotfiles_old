#!/bin/bash

# TODO: Add pre-deployment checks here

# This script assumes that the environment variable $HOME is set to current
# user's home directory.  If not, you need to manually set it here:
#HOME=/home/user_name
DOTFILES=$HOME'/.dotfiles'

# Clone dot files
git clone https://github.com/jaywhang/dotfiles.git $DOTFILES

# Set up Vim
ln -s $DOTFILES/.vimrc $HOME/.vimrc
mkdir -p $HOME/.vim/bundle
mkdir -p $HOME/.vim/swp
mkdir -p $HOME/.vim/undo

# Set up tmux
ln -s $DOTFILES/.tmux.conf $HOME/.tmux.conf

# Set up Git
ln -s $DOTFILES/.gitconfig $HOME/.gitconfig

# TODO: Set up zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
ln -s $DOTFILES/.zshrc $HOME/.zshrc
