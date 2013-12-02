;; make the standard Emacs dismissal key work
(local-set-key (kbd "q") (lambda ()
                           (interactive)
                           (kill-buffer (current-buffer))))
