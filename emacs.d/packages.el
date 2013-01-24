;; satisfy dependencies
(require 'eieio)  ;; needed by gh.el

;; prepare the package system
(package-initialize)

;; add the Marmalade archive
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; install required packages
(setq jeg2s-required-packages
      (list 'color-theme-sanityinc-tomorrow 'fill-column-indicator 'full-ack 'gh
            'idomenu 'inf-ruby 'magit 'markdown-mode 'rainbow-mode
            'ruby-compilation 'rvm 'yasnippet))

(dolist (package jeg2s-required-packages)
  (when (not (package-installed-p package))
    (package-refresh-contents)
    (package-install package)))

;; load theme
(load-theme 'sanityinc-tomorrow-bright t)

(defun jeg2s-htmlify-buffer-dark ()
  "Converts the entire buffer in syntax highlighted HTML."
  (interactive)
  (htmlfontify-buffer)
  (mark-whole-buffer)
  (replace-string "font-size: 0pt;" "font-size: 14pt;")
  (mark-whole-buffer)
  (replace-string "font-family: default;" "font-family: \"DejaVu Sans Mono\"")
  (save-buffer)
  (call-process "open" nil nil nil (buffer-file-name))
  (kill-buffer))
(global-set-key (kbd "C-c H") 'jeg2s-htmlify-buffer-dark)
(defun jeg2s-htmlify-buffer-light ()
  "Converts the entire buffer in syntax highlighted HTML."
  (interactive)
  (load-theme 'sanityinc-tomorrow-day t)
  (jeg2s-htmlify-buffer-dark)
  (load-theme 'sanityinc-tomorrow-bright t))
(global-set-key (kbd "C-c h") 'jeg2s-htmlify-buffer-light)

;; configure Fill-Column-Indicator
(require 'fill-column-indicator)
(setq jeg2s-wrap-limit 80)
(setq jeg2s-buffer-is-wrapped nil)
(defun jeg2s-toggle-wrap ()
  (interactive)
  (if jeg2s-buffer-is-wrapped
      (progn (fci-mode 0)
             (longlines-mode 0)
             (setq jeg2s-buffer-is-wrapped nil))
    (unless (or (= (elt (buffer-name) 0) ?*)
                (= (elt (buffer-name) 0) ?\ )
                (string-match (concat "\\.\\(?:"
                                      (mapconcat 'identity
                                                 '("erb"
                                                   "html"
                                                   "org"
                                                   "yasnippet")
                                                 "\\|")
                                      "\\)\\'") (buffer-name))
                (eq (buffer-local-value 'major-mode (current-buffer))
                    'dired-mode)
                (eq (buffer-local-value 'major-mode (current-buffer))
                    'wdired-mode))
      (setq fill-column jeg2s-wrap-limit)
      (setq fci-rule-column jeg2s-wrap-limit)
      (fci-mode 1)
      (longlines-mode 1)
      (setq jeg2s-buffer-is-wrapped t))))
(add-hook 'after-change-major-mode-hook
          (lambda ()
            (make-local-variable 'jeg2s-buffer-is-wrapped)
            (jeg2s-toggle-wrap)))
(global-set-key (kbd "C-c v w") 'jeg2s-toggle-wrap)

;; add a keystroke for idomenu
(global-set-key (kbd "C-c s") 'idomenu)

;; add keystrokes for inf-ruby
(require 'inf-ruby)
(setq inf-ruby-first-prompt-pattern "^>>\s*")
(setq inf-ruby-prompt-pattern       "^\\(>>\s*\\)")
(global-set-key (kbd "C-c o r") 'inf-ruby)

(defun jeg2s-rails-console ()
  "Invoke inf-ruby with Rails environment loaded."
  (interactive)
  (let ((config (jeg2s-find-in-path "config/environment.rb")))
    (if config
        (run-ruby (concat "irb --inf-ruby-mode -r irb/completion -r " config)
                  "ruby"))))
(global-set-key (kbd "C-c o R") 'jeg2s-rails-console)

;; add keystrokes for full-ack
(global-set-key (kbd "C-c a") 'ack-same)
(global-set-key (kbd "C-c A") 'ack)

;; configure markdown-mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdn"   . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown"    . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md"       . markdown-mode))

(defun jeg2s-markdown-yank-as-pre ()
  (interactive)
  (call-interactively 'yank)
  (call-interactively 'exchange-point-and-mark)
  (call-interactively 'exchange-point-and-mark)
  (call-interactively 'markdown-pre-region))
(add-hook 'markdown-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c y") 'jeg2s-markdown-yank-as-pre)))

;; load rainbow-mode as needed
(add-hook 'css-mode-hook (lambda () (rainbow-mode)))

;; load ruby-compilation so it can set bindings and add a keystroke
(require 'ruby-compilation)
(global-set-key (kbd "C-c o t") 'ruby-compilation-rake)

;; load rvm as needed
(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))

;; configure YASnippet
(require 'yasnippet)
(yas/initialize)
(setq yas/root-directory (expand-file-name "snippets" user-emacs-directory))
(yas/load-directory yas/root-directory)
(setq yas/prompt-functions '(yas/ido-prompt))
(add-hook 'after-change-major-mode-hook
          (lambda ()
            (setq yas/buffer-local-condition t)))
(add-hook 'yas/before-expand-snippet-hook
          (lambda ()
            (if (and (= 1 (line-number-at-pos))
                     (= 1 (count-lines (point-min) (point-max))))
                (progn (call-interactively 'jeg2s-newline-below)
                       (previous-line)))
            (if jeg2s-buffer-is-wrapped
                (progn (fci-mode       0)
                       (longlines-mode 0)))
            (if (eq major-mode 'ruby-mode)
                (remove-hook 'after-change-functions #'erm-req-parse t))))
(add-hook 'yas/after-exit-snippet-hook
          (lambda ()
            (if jeg2s-buffer-is-wrapped
                (progn (fci-mode       1)
                       (longlines-mode 1)))
            (if (eq major-mode 'ruby-mode)
                (progn (erm-reset-buffer)
                       (indent-for-tab-command)))))
(add-hook 'ruby-mode-hook
          (lambda () (setq yas/fallback-behavior
                           '(apply indent-for-tab-command))))

;; add vendored packages to load path
(setq jeg2s-vendored-packages
      (expand-file-name "vendor" user-emacs-directory))

(dolist (project (directory-files jeg2s-vendored-packages t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; load expand-region and bind it to a keystroke
;;
;; fetch expand-region.el submodule (for use with this repository):
;;
;;   git submodule init
;;   git submodule update
;;
;; or set the expand-region.el submodule (for others to use):
;;
;;   git submodule add https://github.com/JEG2/expand-region.el.git \
;;                     emacs.d/vendor/expand-region
(load (expand-file-name "vendor/expand-region/loaddefs.el"
                        user-emacs-directory))
(global-set-key (kbd "C-c e") 'er/expand-region)

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

;; load and configure rhtml
;;
;; fetch rhtml submodule (for use with this repository):
;;
;;   git submodule init
;;   git submodule update
;;
;; or set the rhtml submodule (for others to use):
;;
;;   git submodule add https://github.com/eschulte/rhtml.git \
;;                     emacs.d/vendor/rhtml
(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))

;; load enhanced ruby mode
;;
;; fetch enhanced ruby mode submodule (for use with this repository):
;;
;;   git submodule init
;;   git submodule update
;;
;; or set the enhanced ruby mode submodule (for others to use):
;;
;;   git submodule add https://github.com/jacott/Enhanced-Ruby-Mode.git \
;;                     emacs.d/vendor/Enhanced-Ruby-Mode
(load (expand-file-name "vendor/Enhanced-Ruby-Mode/ruby-mode.elc"
                        user-emacs-directory))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
