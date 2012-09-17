;; fix S-<up> in xterm
;; why:  http://lists.gnu.org/archive/html/help-gnu-emacs/2011-05/msg00211.html
(if (equal "xterm" (tty-type))
    (define-key input-decode-map "\e[1;2A" [S-up]))
(defadvice terminal-init-xterm (after select-shift-up activate)
  (define-key input-decode-map "\e[1;2A" [S-up]))

;; use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq         tab-width        4)
(setq         tab-stop-list    (number-sequence 4 120 4))

;; trim trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; show columns and time in modeline
(column-number-mode 1)

(setq display-time-day-and-date t
      display-time-24hr-format  t)
(display-time)

;; move backups into .emacs.d/backups
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backups" user-emacs-directory))))

;; use Ido
(ido-mode                      1)
(setq ido-everywhere           t)
(setq ido-enable-flex-matching t)

;; upgrade normal expansion to Hippie Expand
(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-all-abbrevs
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

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
; but not in org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (set (make-local-variable 'electric-indent-functions)
                 (list (lambda (arg) 'no-indent)))))

;; show junk whitespace
(setq whitespace-style        '(face tabs trailing lines empty))
(setq whitespace-line-column  jeg2s-wrap-limit)
(setq whitespace-global-modes '(not org-mode))
(global-whitespace-mode 1)
(global-set-key (kbd "C-c SPC")
                (lambda ()
                  (interactive)
                  (untabify (point-min) (point-max))
                  (whitespace-cleanup)))

;; check spelling (requires:  brew install aspell --lang=en)
(add-hook 'text-mode-hook  ;; covers Markdown
          (lambda () (flyspell-mode 1)))
(setq jeg2s-skipped-markdown-faces
      '(markdown-pre-face markdown-reference-face markdown-url-face))
(defun jeg2s-markdown-mode-flyspell-verify ()
  (let ((f (get-text-property (point) 'face)))
    (not (memq f jeg2s-skipped-markdown-faces))))
(put 'markdown-mode 'flyspell-mode-predicate
     'jeg2s-markdown-mode-flyspell-verify)

(setq jeg2s-prog-spelled-modes
      '(css sh emacs-lisp html ruby))
(dolist (mode jeg2s-prog-spelled-modes)
  (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
            (lambda () (flyspell-prog-mode))))

;; expand file type coverage
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$"  . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$"  . ruby-mode))

;; erc
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))

(setq erc-max-buffer-size 50000)
(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
(setq erc-truncate-buffer-on-save t)

;; configure re-builder
(require 're-builder)
(setq reb-re-syntax 'string)
(global-set-key (kbd "C-c o e") 're-builder)

;; configure tramp
(require 'tramp)
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))

;; configure org-mode
(setq org-startup-truncated nil)
