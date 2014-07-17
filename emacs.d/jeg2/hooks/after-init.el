;; frame and window management
(global-set-key (kbd "C-c f c") 'make-frame-command)
(global-set-key (kbd "C-c f k") 'delete-frame)
(global-set-key (kbd "C-c f f") (lambda ()
                                  (interactive)
                                  (other-frame -1)))
(global-set-key (kbd "C-c f F") (lambda ()
                                  (interactive)
                                  (other-frame 1)))

(global-set-key (kbd "C-c -") 'split-window-vertically)
(global-set-key (kbd "C-c |") 'split-window-horizontally)
(global-set-key (kbd "C-x o") (lambda ()
                                (interactive)
                                (other-window -1)))
(global-set-key (kbd "C-x O") (lambda ()
                                (interactive)
                                (other-window 1)))

(global-set-key (kbd "C-M-n") 'jeg2/other-window-next-line)
(global-set-key (kbd "C-M-p") 'jeg2/other-window-previous-line)

(require 'window-number)
(window-number-mode)
;; tone down the garish appearance
(set-face-attribute 'window-number-face nil :background "#2a2a2a")
(set-face-attribute 'window-number-face nil :foreground "red")

(winner-mode)

(global-undo-tree-mode)

;; unbind some keystrokes
(global-unset-key (kbd "C-x C-u"))
(global-unset-key (kbd "C-/"))
(global-unset-key (kbd "C-x C-b"))

;; command shortcuts
(global-set-key (kbd "M-/") 'hippie-expand)

(global-set-key (kbd "M-;") 'jeg2/comment-or-uncomment-region-or-line)

(global-set-key (kbd "C-c l")   'jeg2/newline-below)
(global-set-key (kbd "C-c L")   'jeg2/newline-above)
(global-set-key (kbd "C-c RET") 'jeg2/newline-between)

(global-set-key (kbd "C-x r e") 'mc/edit-lines)

(global-set-key (kbd "C-c ;") 'jeg2/insert-header-comment)

(global-set-key (kbd "C-c r")   'replace-string)
(global-set-key (kbd "C-c R")   'replace-regexp)
(global-set-key (kbd "C-c o e") 're-builder)

(global-set-key (kbd "C-c e") 'er/expand-region)

(global-set-key (kbd "C-c s") 'idomenu)

(global-set-key (kbd "C-c a") 'ag-project-regexp)
(global-set-key (kbd "C-c A") 'ag-project-dired-regexp)

(global-set-key (kbd "C-c H") 'jeg2/htmlify-buffer)
(global-set-key (kbd "C-c h") 'jeg2/htmlify-buffer-light)

(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g b") 'vc-annotate)
(global-set-key (kbd "C-c g p") 'yagist-region-or-buffer)

(global-set-key (kbd "C-c w b") 'jeg2/trim-backwards)
(global-set-key (kbd "C-c w f") 'jeg2/trim-forwards)
(global-set-key (kbd "C-c w a") 'jeg2/trim-backwards-and-forwards)
(global-set-key (kbd "C-c w t") 'delete-trailing-whitespace)
(global-set-key (kbd "C-c w w") 'fixup-whitespace)
(global-set-key (kbd "C-c SPC") 'jeg2/fix-all-whitespace)

(global-set-key (kbd "C-c v l") 'linum-mode)

(global-set-key (kbd "C-c o r") 'inf-ruby)
(global-set-key (kbd "C-c o R") 'jeg2/rails-console)
(global-set-key (kbd "C-c o d") 'jeg2/rails-dbconsole)
(global-set-key (kbd "C-c o s") 'jeg2/open-shell-in-ansi-term)
(global-set-key (kbd "C-c o m") 'man)
(global-set-key (kbd "C-c o c") 'calc)
(global-set-key (kbd "C-c o l") 'ielm)
(global-set-key (kbd "C-c o i") 'jeg2/erc-connect)
