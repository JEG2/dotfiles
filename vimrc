"""""""""""""""
""" Setting """
"""""""""""""""

set nocompatible                  " Changes other options.

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " Case-sensitive if it contains a capital.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set nobackup                      " Don't backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location.

set tabstop=2                     " Global tab width.
set shiftwidth=2                  " And again, related.
set expandtab                     " Use spaces instead of tabs.

""""""""""""
""" Keys """
""""""""""""

let mapleader=","

"""""""""""""""
""" Plugins """
"""""""""""""""

"
" Install Pathogen
" http://www.vim.org/scripts/script.php?script_id=2332
"

call pathogen#runtime_append_all_bundles() 

"
" Install Rooter
" https://github.com/airblade/vim-rooter
"

"
" Install NERD tree
" http://www.vim.org/scripts/script.php?script_id=1658
"

"
" Install Ack.vim (requires ack)
" http://www.vim.org/scripts/script.php%3Fscript_id%3D2572
"

"
" Install Gist.vim (requires git)
" http://www.vim.org/scripts/script.php?script_id=2423
"
