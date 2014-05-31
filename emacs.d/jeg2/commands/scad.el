;;;###autoload
(defun jeg2/scad-preview ()
  "Preview the current buffer as a PNG image."
  (interactive)
  (save-buffer)
  (call-process "openscad" nil nil nil "-o" (concat (file-name-sans-extension (buffer-file-name)) ".png") (buffer-file-name))
  (call-process "open" nil nil nil (concat (file-name-sans-extension (buffer-file-name)) ".png")))
