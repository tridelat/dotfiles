#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------- emacs ----------
ln -sfn ${BASEDIR}/.emacs ~/.emacs
ln -sfn ${BASEDIR}/.emacs.d/ ~/.emacs.d

# ---------- vim ----------
ln -sfn ${BASEDIR}/.vimrc ~/.vimrc
ln -sfn ${BASEDIR}/.vim/ ~/.vim
# install Vundle
if [ ! -d ${BASEDIR}/.vim/bundle ]
then
    mkdir ${BASEDIR}/.vim
    mkdir ${BASEDIR}/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim.git ${BASEDIR}/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi
# install plugins through vundle

# ---------- zsh ----------
if [ ! -d ${BASEDIR}/.antigen ]
then
    git clone https://github.com/powerline/fonts ${BASEDIR}/.antigen
    ln -sfn ${BASEDIR}/.antigen/ ~/.antigen
fi
if [ ! -d ${BASEDIR}/fonts ]
then
    git clone https://github.com/powerline/fonts ${BASEDIR}/fonts
    ${BASEDIR}/fonts/install.sh
fi
if [ ! -d ${BASEDIR}/gnome-terminal-colors-solarized ]
then
    git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git ${BASEDIR}/gnome-terminal-colors-solarized
    ${BASEDIR}/gnome-terminal-colors-solarized/install.sh
    gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "Ubuntu Mono derivative Powerline 12"
fi
# chsh -s /bin/zsh

