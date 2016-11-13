(defun jeg2/newline-between ()
  "Splits content before and after the point to insert new content between."
  (interactive)
  (jeg2/trim-backwards-and-forwards)
  (newline)
  (newline)
  (indent-for-tab-command)
  (previous-line)
  (indent-for-tab-command))

(defun jeg2/close-statement ()
  "Jumps to the end of the line and adds statement-end (default: ;)."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (let ((ender (or (and (boundp 'statement-end) statement-end) ";")))
    (unless (looking-back (regexp-quote ender))
      (insert ender))))
