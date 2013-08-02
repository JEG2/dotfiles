;;;###autoload
(defun jeg2/markdown-yank-as-pre ()
  "Yank in some text as preformatted."
  (interactive)
  (call-interactively 'yank)
  (call-interactively 'exchange-point-and-mark)
  (call-interactively 'exchange-point-and-mark)
  (call-interactively 'markdown-pre-region))

;;;###autoload
(defun jeg2/markdown-preview ()
  "Preview the current buffer in Marked."
  (interactive)
  (save-buffer)
  (call-process "open" nil nil nil "-a" "Marked.app" (buffer-file-name)))
