(defun jeg2/ansi-color-apply-buffer ()
  "Turns on ANSI coloring in the whole buffer."
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))
