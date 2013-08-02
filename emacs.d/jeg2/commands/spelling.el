;;;###autoload
(defun jeg2/toggle-program-spelling ()
  "Toggle the programmer's spelling mode on and off."
  (interactive)
  (if (and (boundp 'flyspell-mode) flyspell-mode)
      (flyspell-mode 0)
    (flyspell-prog-mode)))

;;;###autoload
(defun jeg2/toggle-spelling ()
  "Toggle the spelling mode on and off."
  (interactive)
  (if (and (boundp 'flyspell-mode) flyspell-mode)
      (flyspell-mode 0)
    (flyspell-mode 1)))
