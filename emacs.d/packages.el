;; satisfy dependencies
(require 'eieio)  ;; needed by gh.el

;; prepare the package system
(package-initialize)

;; add the Marmalade archive
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/"))

;; install required packages
(setq jeg2-required-packages 
  (list 'magit 'gh 'markdown-mode 'yasnippet))

(dolist (package jeg2-required-packages)
  (when (not (package-installed-p package))
    (package-refresh-contents)
    (package-install package)))

;; configure markdown-mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdn"   . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown"    . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md"       . markdown-mode))

;; configure YASnippet
(require 'yasnippet)
(yas/initialize)
(setq yas/root-directory (expand-file-name "snippets" user-emacs-directory))
(setq yas/prompt-functions '(yas/ido-prompt))
(yas/load-directory yas/root-directory)

;; add vendored packages to load path
(setq jeg2-vendored-packages 
  (expand-file-name "vendor" user-emacs-directory))

(dolist (project (directory-files jeg2-vendored-packages t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; load gist
;; 
;; fetch gist.el submodule (for use with this repository):
;; 
;;   git submodule init
;;   git submodule update
;; 
;; or set the gist.el submodule (for others to use):
;;
;;   git submodule add https://github.com/mhayashi1120/gist.el.git \
;;                     emacs.d/vendor/gist
(load (expand-file-name "vendor/gist/loaddefs.el" user-emacs-directory))
(setq gist-authenticate-function 'gist-basic-authentication)

;; load mo-git-blame
;; 
;; fetch mo-git-blame.el submodule (for use with this repository):
;; 
;;   git submodule init
;;   git submodule update
;; 
;; or set the mo-git-blame.el submodule (for others to use):
;;
;;   git submodule add https://github.com/voins/mo-git-blame.git \
;;                     emacs.d/vendor/mo-git-blame
(autoload 'mo-git-blame-file    "mo-git-blame.el"
  "Show an interactive git blame session for a specified file" t)
(autoload 'mo-git-blame-current "mo-git-blame.el"
  "Show an interactive git blame session for the current file" t)

;; load pbcopy
;;
;; fetch code:
;; 
;;   mkdir emacs.d/vendor/pbcopy
;;   cd emacs.d/vendor/pbcopy
;;   curl -O https://raw.github.com/wesen/emacs/master/pbcopy.el
(require 'pbcopy)
(turn-on-pbcopy)
