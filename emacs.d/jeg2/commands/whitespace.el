;;;###autoload
(defun jeg2/trim-backwards ()
  "Removes all whitespace behind the point."
  (interactive)
  (while (looking-back "[\s\t\n]")
    (backward-delete-char-untabify 1)))

;;;###autoload
(defun jeg2/trim-forwards ()
  "Removes all whitespace in front of the point."
  (interactive)
  (while (looking-at "[\s\t\n]")
    (delete-char 1)))

;;;###autoload
(defun jeg2/trim-backwards-and-forwards ()
  "Removes all whitespace behind and in front of the point."
  (interactive)
  (jeg2/trim-backwards)
  (jeg2/trim-forwards))

;;;###autoload
(defun jeg2/fix-all-whitespace ()
  "Replace tabs and cleans up junk whitespace."
  (interactive)
  (untabify (point-min) (point-max))
  (whitespace-cleanup))
