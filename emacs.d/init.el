;; JEG2's Emacs configuration

;; load configuration settings by type
(load (expand-file-name "packages.el"    user-emacs-directory))  ;; load first
(load (expand-file-name "secrets.el"     user-emacs-directory))  ;; not in Git
(load (expand-file-name "settings.el"    user-emacs-directory))
(load (expand-file-name "appearance.el"  user-emacs-directory))
(load (expand-file-name "keybindings.el" user-emacs-directory))  ;; load last
