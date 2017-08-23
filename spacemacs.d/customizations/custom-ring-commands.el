(defun jeg2/yank-path (&optional @dirname)
  "Copy the current buffer's file path or dired path to `kill-ring'. Result is full path. With the `universal-argument', copies the path of the containing directory."
  (interactive "P")
  (let (($fpath
         (if (equal major-mode 'dired-mode)
             (expand-file-name default-directory)
           (if (buffer-file-name)
               (buffer-file-name)
             (user-error "Current buffer is not associated with a file.")))))
    (kill-new
     (if @dirname
         (progn
           (message "Directory path copied: 「%s」" (file-name-directory $fpath))
           (file-name-directory $fpath))
       (progn
         (message "File path copied: 「%s」" $fpath)
         $fpath)))))
