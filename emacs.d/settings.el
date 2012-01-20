;; move backups into .emacs.d/backups
(setq backup-directory-alist
  (list (cons "." (expand-file-name "backups" user-emacs-directory))))

;; use Ido
(ido-mode                      1)
(setq ido-everywhere           t)
(setq ido-enable-flex-matching t)

;; upgrade normal expansion to Hippie Expand
(global-set-key (kbd "M-/") 'hippie-expand)
