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
alias proteus='export PATH=~/PROTEUS/proteus/linux2/bin:$PATH'
