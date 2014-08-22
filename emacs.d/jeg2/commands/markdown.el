;;;###autoload
(defun jeg2/insert-fenced-code-block (&optional add-yank)
  "Inserts fenced code blocks, optionally with yanked text between."
  (interactive "P")
  (if add-yank (call-interactively 'yank))
  (dotimes (_ 3) (insert "`"))
  (let ((return-to (point)))
    (newline-and-indent)
    (if add-yank
        (progn
          (goto-char (mark))
          (unless (bolp) (newline-and-indent))))
    (dotimes (_ 3) (insert "`"))
    (goto-char return-to)))

;;;###autoload
(defun jeg2/markdown-preview ()
  "Preview the current buffer in Marked."
  (interactive)
  (save-buffer)
  (call-process "open" nil nil nil "-a" "Marked 2.app" (buffer-file-name)))
