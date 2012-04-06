;; use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq         tab-width        4)
(setq         tab-stop-list    (number-sequence 4 120 4))

;; show columns
(column-number-mode 1)

;; move backups into .emacs.d/backups
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backups" user-emacs-directory))))

;; use Ido
(ido-mode                      1)
(setq ido-everywhere           t)
(setq ido-enable-flex-matching t)

;; upgrade normal expansion to Hippie Expand
(global-set-key (kbd "M-/") 'hippie-expand)

;; show matching paren, bracket, etc.
(show-paren-mode 1)

;; activate character pairing
(electric-pair-mode 1)
(global-set-key (kbd "'")
                (lambda () (interactive) (insert "'")))  ; don't pair ' anywhere
(add-hook 'ruby-mode-hook
          (lambda () (add-to-list (make-local-variable 'electric-pair-pairs)
                                  '(?| . ?|))))   ; do pair | in Ruby
(add-hook 'css-mode-hook
          (lambda () (add-to-list (make-local-variable 'electric-pair-pairs)
                                  '(?: . ?\;))))   ; pair : with ; in CSS
(add-hook 'markdown-mode-hook
          (lambda () (add-to-list (make-local-variable 'electric-pair-pairs)
                                  '(?` . ?`))))   ; do pair ` in Markdown

;; turn on autoindenting
(electric-indent-mode 1)

;; show junk whitespace
(setq whitespace-style '(face tabs trailing lines empty))
(setq whitespace-line-column jeg2s-wrap-limit)
(global-whitespace-mode 1)
(global-set-key (kbd "C-c SPC")
                (lambda ()
                  (interactive)
                  (untabify (point-min) (point-max))
                  (whitespace-cleanup)))

;; check spelling (requires:  brew install aspell --lang=en)
(setq jeg2s-prog-spelled-modes
      '(css sh emacs-lisp html ruby))
(add-hook 'text-mode-hook
          (lambda () (flyspell-mode 1)))
(dolist (mode jeg2s-prog-spelled-modes)
  (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
            (lambda () (flyspell-prog-mode))))
