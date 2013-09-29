(defun jeg2/delete-out-of-date-bytecode (directory)
  "Remove any .elc file in the directory where the matching .el file is newer."
  (dolist (path-and-attributes (directory-files-and-attributes directory t))
    (let ((path       (car path-and-attributes))
          (attributes (cdr path-and-attributes)))
      (cond ((string-prefix-p "." (file-name-nondirectory path))
             nil)  ; skip invisible directories
            ((car attributes)
             (jeg2/delete-out-of-date-bytecode path))
            ((string-match "\\.elc\\'" path)
             (let ((el-file (substring path 0 -1)))
               (when (and (file-exists-p el-file)
                          (file-newer-than-file-p el-file path))
                 (delete-file path))))))))

(jeg2/delete-out-of-date-bytecode
 (expand-file-name "jeg2" user-emacs-directory))
