# -*- sh -*-

source ~/Documents/dotfiles/bash/env
source ~/Documents/dotfiles/bash/config
source ~/Documents/dotfiles/bash/aliases
[[ -f ~/Documents/dotfiles/bash/secrets ]] && source ~/Documents/dotfiles/bash/secrets

# asdf
export ASDF_DATA_DIR="/Users/james/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# z
. /usr/local/etc/profile.d/z.sh
