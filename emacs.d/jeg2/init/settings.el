(defun jeg2/load-settings ()
  "Loads all Lisp files in the settings subdirectory of the init directory."
  (dolist (file (directory-files (concat user-emacs-directory "jeg2/settings")
                                 nil
                                 "\\.el$"))
    (jeg2/load-init-file (concat "jeg2/settings/" file))))

(jeg2/load-settings)
