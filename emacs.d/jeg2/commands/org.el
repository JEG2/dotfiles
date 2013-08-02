;;;###autoload
(defun jeg2/org-new-heading-below ()
  "Creates a new heading below the current one."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (org-insert-heading-respect-content t))

;;;###autoload
(defun jeg2/org-new-heading-above ()
  "Creates a new heading above the current one."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (org-insert-heading-respect-content t))
