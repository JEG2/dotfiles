# -*- sh -*-

source ~/Documents/dotfiles/bash/env
source ~/Documents/dotfiles/bash/config
source ~/Documents/dotfiles/bash/aliases

# chruby
source /usr/local/share/chruby/chruby.sh
# source /usr/local/share/chruby/auto.sh
chruby ${JEG2_RUBY_VERSION-ruby-2.2.3}
