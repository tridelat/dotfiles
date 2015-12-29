#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------- emacs ----------
echo -n "Install configuration for Spacemacs/Emacs/None [S/e/n]: "
read ANSWER
ANSWER="${ANSWER:=S}"
case $ANSWER in
    [E/e/Emacs/emacs]*)
        ln -sfn ${BASEDIR}/.emacs ~/.emacs
        ln -sfn ${BASEDIR}/.emacs.d/ ~/.emacs.d
        ;;
    [S/s/Spacemacs/spacemacs]*)
        ln -sfn ${BASEDIR}/.spacemacs ~/.spacemacs

        if [ ! -d ${BASEDIR}/.spacemacs.d ]
        then
            git clone https://github.com/syl20bnr/spacemacs ${BASEDIR}/.spacemacs.d
        fi
        ln -sfn ${BASEDIR}/.spacemacs.d ~/.emacs.d
        ;;
    [N/n/None]*)
        break
        ;;
esac


# ---------- vim ----------
echo -n "Install vim configuration [Y/n]: "
read ANSWER
ANSWER="${ANSWER:=Y}"
if [[ $ANSWER =~ ^[Yy]$ ]]
then
    ln -sfn ${BASEDIR}/.vimrc ~/.vimrc
    ln -sfn ${BASEDIR}/.vim/ ~/.vim
    # install Vundle
    if [ ! -d ${BASEDIR}/.vim/bundle ]
    then
        mkdir ${BASEDIR}/.vim
        mkdir ${BASEDIR}/.vim/bundle
        git clone https://github.com/VundleVim/Vundle.vim.git ${BASEDIR}/.vim/bundle/Vundle.vim
        # install plugins through vundle
        vim +PluginInstall +qall
    fi
fi

# ---------- zsh ----------
echo -n "Install z shell configuration [Y/n]: "
read ANSWER
ANSWER="${ANSWER:=Y}"
if [[ $ANSWER =~ ^[Yy]$ ]]
    then
    ln -sfn ${BASEDIR}/.zshrc ~/.zshrc
    if [ ! -d ${BASEDIR}/.antigen ]
    then
        git clone https://github.com/zsh-users/antigen ${BASEDIR}/.antigen
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
    fi
fi
