;;;###autoload
(defun jeg2/toggle-wrap ()
  "Toggle the wrap guide and soft wrapping on and off."
  (interactive)
  (if (and (boundp 'fci-mode) fci-mode)
      (progn (fci-mode        0)
             (longlines-mode 0))
    (fci-mode       1)
    (longlines-mode 1)))
