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
(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c b") 'vc-annotate)
(global-set-key (kbd "C-c p") 'gist-region-or-buffer)

;; shortcuts
(global-set-key (kbd "C-c l") 'linum-mode)
(global-set-key (kbd "C-c t") (lambda ()
                                (interactive)
                                (ansi-term "bash" "localhost")))

;; custom keystrokes
(defun jeg2s-newline-below (skip-eol)
  "Insert a new line below the current line and indent it."
  (interactive "P")
  (unless (or (eolp) skip-eol)
    (end-of-line))
  (newline-and-indent))
(global-set-key (kbd "C-c o") 'jeg2s-newline-below)
(defun jeg2s-newline-above ()
  "Insert a new line above the current line and indent it."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (previous-line)
  (indent-according-to-mode))
(global-set-key (kbd "C-c O") 'jeg2s-newline-above)

(defun jeg2s-duplicate-line-or-region ()
  "Duplicate the current region, or line, and leave it selected."
  (interactive)
  (let (deactivate-mark)
    (unless (region-active-p)
      (if (= (line-number-at-pos) (count-lines (point-min) (point-max)))
          (progn (call-interactively 'jeg2s-newline-below)
                 (previous-line)))
      (unless (bolp)
        (beginning-of-line))
      (call-interactively 'set-mark-command)
      (next-line))
    (call-interactively 'kill-region)
    (yank)
    (yank)
    ;; I would prefer to use (activate-mark) below, but it fails in the
    ;; starting case of an unselected line
    (kmacro-exec-ring-item (quote ("" 0 "%d")) nil)))
(global-set-key (kbd "C-c d") 'jeg2s-duplicate-line-or-region)
