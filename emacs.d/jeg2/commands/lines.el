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
  ;; (indent-for-tab-command)
  (newline)
  (newline)
  (indent-for-tab-command)
  (previous-line)
  (indent-for-tab-command))
