eval "$(/opt/homebrew/bin/brew shellenv)"

. ~/Documents/dotfiles/zsh/env
. ~/Documents/dotfiles/zsh/aliases
[[ -f ~/Documents/dotfiles/zsh/secrets ]] && . ~/Documents/dotfiles/zsh/secrets

# asdf
export ASDF_DATA_DIR="/Users/james/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"
