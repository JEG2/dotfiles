;;;###autoload
(defun jeg2/newline-below (skip-eol)
  "Insert a new line below the current line and indent it."
  (interactive "P")
  (unless (or (eolp) skip-eol)
    (end-of-line))
  (newline-and-indent))

;;;###autoload
(defun jeg2/newline-above ()
  "Insert a new line above the current line and indent it."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (previous-line)
  (indent-according-to-mode))

;;;###autoload
(defun jeg2/newline-between ()
  "Splits content before and after the point to insert new content between."
  (interactive)
  (jeg2/trim-backwards-and-forwards)
  (newline)
  (newline)
  (indent-for-tab-command)
  (previous-line)
  (indent-for-tab-command))

;;;###autoload
(defun jeg2/close-statement ()
  "Jumps to the end of the line and adds statement-end (default: ;)."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (let ((ender (or (and (boundp 'statement-end) statement-end) ";")))
    (unless (looking-back (regexp-quote ender))
      (insert ender))))
