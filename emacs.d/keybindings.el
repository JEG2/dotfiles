;; window management
(global-set-key (kbd "C-c f c")     'make-frame-command)
(global-set-key (kbd "C-c f k")     'delete-frame)
(global-set-key (kbd "C-c f f")     'other-frame)
(global-set-key (kbd "C-c -")       'split-window-vertically)
(global-set-key (kbd "C-c |")       'split-window-horizontally)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "C-x O")       (lambda ()
                                      (interactive)
                                      (other-window -1)))

;; Git
(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g b") 'vc-annotate)
(global-set-key (kbd "C-c g p") 'gist-region-or-buffer)

;; shortcuts
(global-set-key (kbd "C-c v l") 'linum-mode)

(global-set-key (kbd "C-c o s") (lambda ()
                                  (interactive)
                                  (ansi-term "bash" "localhost")))
(global-set-key (kbd "C-c o m") 'man)
(global-set-key (kbd "C-c o c") 'calc)
(global-set-key (kbd "C-c o l") 'ielm)
