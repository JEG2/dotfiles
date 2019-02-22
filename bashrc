# -*- sh -*-

source ~/Documents/dotfiles/bash/env
source ~/Documents/dotfiles/bash/config
source ~/Documents/dotfiles/bash/aliases
[[ -f ~/Documents/dotfiles/bash/secrets ]] && source ~/Documents/dotfiles/bash/secrets

# asdf
export RUBY_CONFIGURE_OPTIONS='--with-opt-dir=/usr/local/opt/openssl:/usr/local/opt/readline:/usr/local/opt/libyaml:/usr/local/opt/gdbm'
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# z
. /usr/local/etc/profile.d/z.sh
