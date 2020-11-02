# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.antigen/antigen.zsh
TERM='xterm-256color'
antigen use oh-my-zsh

antigen bundle git
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle python

antigen theme agnoster

antigen apply

# set spelling correction and modify original prompt
setopt correct
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r?$reset_color (Yes, No, Abort, Edit) "


autoload -Uz compinit
compinit

setopt histignorealldups sharehistory
#
## Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
#HISTSIZE=1000
#SAVEHIST=1000
#HISTFILE=~/.zsh_history
#
export PATH=~/.local/bin:$PATH

alias kbfr='setxkbmap -layout us -variant intl'
alias kben='setxkbmap -layout us'
alias azerty='setxkbmap -layout fr'
alias qwerty='setxkbmap -layout us'

export EDITOR='vim'

alias gla='git log --graph --decorate --pretty=oneline --abbrev-commit --all'

source ~/dotfiles/.powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
