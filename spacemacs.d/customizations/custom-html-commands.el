(defun jeg2/htmlify-buffer ()
  "Converts the entire buffer in syntax highlighted HTML."
  (interactive)
  (htmlfontify-buffer)
  (mark-whole-buffer)
  (replace-string "font-size: 0pt;" "font-size: 14pt;")
  (mark-whole-buffer)
  (replace-string "font-family: default;" "font-family: \"DejaVu Sans Mono\"")
  (save-buffer)
  (call-process "open" nil nil nil "-a" "Safari.app" (buffer-file-name))
  (kill-buffer))

(defun jeg2/htmlify-buffer-reversed ()
  "Converts the entire buffer in syntax highlighted HTML using the next theme (assumed to be a reversed theme)."
  (interactive)
  (spacemacs/cycle-spacemacs-theme)
  (jeg2/htmlify-buffer)
  (spacemacs/cycle-spacemacs-theme))
