;;;###autoload
(defun jeg2/scad-preview ()
  "Preview the current buffer as a PNG image."
  (interactive)
  (save-buffer)
  (let ((png (concat (file-name-sans-extension (buffer-file-name)) ".png")))
    (if (= (call-process "openscad" nil nil nil "-o" png (buffer-file-name)) 0)
        (call-process "open" nil nil nil png)
      (message "OpenSCAD failed with an error."))))
