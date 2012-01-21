;; move backups into .emacs.d/backups
(setq backup-directory-alist
  (list (cons "." (expand-file-name "backups" user-emacs-directory))))

;; use Ido
(ido-mode                      1)
(setq ido-everywhere           t)
(setq ido-enable-flex-matching t)

;; upgrade normal expansion to Hippie Expand
(global-set-key (kbd "M-/") 'hippie-expand)

;; indent newlines by default in appropriate modes
(setq jeg2-autoindenting-modes
  (list 'emacs-lisp-mode-hook 'markdown-mode-hook 'ruby-mode-hook))
(loop for hook in jeg2-autoindenting-modes do
  (add-hook hook '(lambda ()
    (local-set-key (kbd "RET") 'newline-and-indent))))
