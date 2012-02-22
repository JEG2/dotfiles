source ~/Documents/dotfiles/bash/env
source ~/Documents/dotfiles/bash/config
source ~/Documents/dotfiles/bash/aliases

# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
