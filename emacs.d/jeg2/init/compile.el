(defun jeg2/byte-recompile-init ()
  "Recompile the files I use to setup Emacs."
  (byte-recompile-directory (expand-file-name "jeg2" user-emacs-directory) 0)
  ;; don't compile init.el because it's too late to freshen it on load
  ;; loaddefs.el cannot be compiled
  (let ((log (get-buffer "*Compile-Log*")))
    (if (and log (= (buffer-size log) 0))
        (kill-buffer "*Compile-Log*")))
  )

(jeg2/byte-recompile-init)
