;;;###autoload
(defun jeg2/align= ()
  "Aligns equal signs in the region or buffer."
  (interactive)
  (if (region-active-p)
      (align-regexp (region-beginning) (region-end) "\\(\\s-*\\)=" 1 1 nil)
    (save-excursion
      (push-mark)
      (activate-mark)
      (unless (bolp)
        (beginning-of-line))
      (while (looking-back "^\\s-*[^(=\n]+\\s-*=.*\n")
        (previous-line))
      (jeg2/align=))))
