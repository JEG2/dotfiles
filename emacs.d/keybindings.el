;; window management
(global-set-key (kbd "C-c c")       'make-frame-command)
(global-set-key (kbd "C-c k")       'delete-frame)
(global-set-key (kbd "C-c n")       'other-frame)
(global-set-key (kbd "C-c -")       'split-window-vertically)
(global-set-key (kbd "C-c |")       'split-window-horizontally)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; Git
(global-set-key (kbd "C-c p") 'gist-region-or-buffer)

;; shortcuts
(global-set-key (kbd "C-c l") 'linum-mode)
(global-set-key (kbd "C-c s") 'shell)
