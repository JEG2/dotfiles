;; satisfy dependencies
(require 'eieio)  ;; needed by gh.el

;; prepare the package system
(package-initialize)

;; add the Marmalade archive
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))

;; install required packages
(setq jeg2s-required-packages
      (list 'fill-column-indicator 'gh 'magit
	    'markdown-mode 'rainbow-mode 'yasnippet))

(dolist (package jeg2s-required-packages)
  (when (not (package-installed-p package))
    (package-refresh-contents)
    (package-install package)))

;; configure Fill-Column-Indicator
(require 'fill-column-indicator)
(setq jeg2s-wrap-limit 80)
(setq jeg2s-buffer-is-wrapped nil)
(defun jeg2s-toggle-wrap ()
  (interactive)
  (if jeg2s-buffer-is-wrapped
      (progn (fci-mode 0)
	     (longlines-mode 0))
    (unless (= (elt (buffer-name) 0) ?*)
      (setq fill-column jeg2s-wrap-limit)
      (setq fci-rule-column jeg2s-wrap-limit)
      (fci-mode 1)
      (longlines-mode 1)))
    (setq jeg2s-buffer-is-wrapped (not jeg2s-buffer-is-wrapped)))
(add-hook 'after-change-major-mode-hook
	  (lambda ()
	    (make-local-variable 'jeg2s-buffer-is-wrapped)
	    (jeg2s-toggle-wrap)))
(global-set-key (kbd "C-c w") 'jeg2s-toggle-wrap)

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
(yas/load-directory yas/root-directory)
(setq yas/prompt-functions '(yas/ido-prompt))
(add-hook 'after-change-major-mode-hook
	  (lambda ()
	    (setq yas/buffer-local-condition t)))

;; configure rainbow-mode
(add-hook 'css-mode-hook (lambda () (rainbow-mode)))

;; add vendored packages to load path
(setq jeg2s-vendored-packages
      (expand-file-name "vendor" user-emacs-directory))

(dolist (project (directory-files jeg2s-vendored-packages t "\\w+"))
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

;; load pbcopy
;;
;; fetch code:
;;
;;   mkdir emacs.d/vendor/pbcopy
;;   cd emacs.d/vendor/pbcopy
;;   curl -O https://raw.github.com/wesen/emacs/master/pbcopy.el
(require 'pbcopy)
(turn-on-pbcopy)
