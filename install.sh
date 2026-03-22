#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

modules=(
    "zsh         Z shell + powerlevel10k theme"
    "vim         Vim + Vundle plugins"
    "emacs       Vanilla Emacs config"
    "spacemacs   Spacemacs distribution"
    "neovim      Neovim + lazy.nvim"
    "sway        Sway + waybar"
    "i3          i3 + i3blocks"
)

echo "Available modules:"
for i in "${!modules[@]}"; do
    printf "  %d) %s\n" "$((i+1))" "${modules[$i]}"
done
echo ""
echo -n "Select modules (space-separated numbers, or 'all'): "
read -r selection

if [[ "$selection" == "all" ]]; then
    selected=($(seq 1 ${#modules[@]}))
else
    read -ra selected <<< "$selection"
fi

for num in "${selected[@]}"; do
    case $num in
        1) # zsh
            ln -sfn "$BASEDIR/.zshrc" ~/.zshrc
            ln -sfn "$BASEDIR/.p10k.zsh" ~/.p10k.zsh
            [[ ! -d "$BASEDIR/.antigen" ]] && git clone https://github.com/zsh-users/antigen "$BASEDIR/.antigen"
            ln -sfn "$BASEDIR/.antigen" ~/.antigen
            [[ ! -d "$BASEDIR/.powerlevel10k" ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$BASEDIR/.powerlevel10k"
            echo "  zsh: done"
            ;;
        2) # vim
            ln -sfn "$BASEDIR/.vimrc" ~/.vimrc
            if [[ ! -d "$BASEDIR/.vim/bundle" ]]; then
                mkdir -p "$BASEDIR/.vim/bundle"
                git clone https://github.com/VundleVim/Vundle.vim.git "$BASEDIR/.vim/bundle/Vundle.vim"
                vim +PluginInstall +qall
            fi
            ln -sfn "$BASEDIR/.vim" ~/.vim
            echo "  vim: done"
            ;;
        3) # emacs
            ln -sfn "$BASEDIR/.emacs" ~/.emacs
            ln -sfn "$BASEDIR/.emacs.d" ~/.emacs.d
            echo "  emacs: done"
            ;;
        4) # spacemacs
            ln -sfn "$BASEDIR/.spacemacs" ~/.spacemacs
            [[ ! -d "$BASEDIR/.spacemacs.d" ]] && git clone https://github.com/syl20bnr/spacemacs "$BASEDIR/.spacemacs.d"
            ln -sfn "$BASEDIR/.spacemacs.d" ~/.emacs.d
            echo "  spacemacs: done"
            ;;
        5) # neovim
            mkdir -p ~/.config
            ln -sfn "$BASEDIR/.config/nvim" ~/.config/nvim
            echo "  neovim: done"
            ;;
        6) # sway
            mkdir -p ~/.config
            ln -sfn "$BASEDIR/.config/sway" ~/.config/sway
            ln -sfn "$BASEDIR/.config/waybar" ~/.config/waybar
            echo "  sway: done"
            ;;
        7) # i3
            mkdir -p ~/.config
            ln -sfn "$BASEDIR/.config/i3" ~/.config/i3
            echo "  i3: done"
            ;;
        *)
            echo "  Unknown module: $num (skipped)"
            ;;
    esac
done
