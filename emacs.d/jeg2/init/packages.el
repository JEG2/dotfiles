(package-initialize)
(dolist (repo '(("elpa"      . "http://tromey.com/elpa/")
                ("marmalade" . "http://marmalade-repo.org/packages/")
                ("melpa"     . "http://melpa.milkbox.net/packages/")))
  (add-to-list 'package-archives repo))

(unless (package-installed-p 'package+)
  (package-refresh-contents)
  (package-install 'package+))

(package-manifest
 'ag
 'coffee-mode
 'color-theme-sanityinc-tomorrow
 'elm-mode
 'expand-region
 'dash
 'dart-mode
 'fill-column-indicator
 'haml-mode
 'idomenu
 'inf-ruby
 'magit
 'markdown-mode
 'multiple-cursors
 'package+
 'paredit
 'pov-mode
 'rainbow-mode
 'rhtml-mode
 'ruby-compilation
 'rust-mode
 'scss-mode
 'smartparens
 'undo-tree
 'window-number
 'yagist
 'yaml-mode
 'yasnippet
 )

;; vendored packages
(jeg2/load-init-file "jeg2/vendor/rcodetools")
(jeg2/load-init-file "jeg2/vendor/scad-mode")

(require 'longlines)  ; an obsolete but not-yet-removed Emacs package
