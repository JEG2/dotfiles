;; JEG2's Emacs configuration

(defun jeg2/load-init-file (path &optional noerror)
  "This loads a file from inside the the .emacs.d directory"
  (let ((file (file-name-sans-extension
               (expand-file-name path user-emacs-directory))))
    (load file noerror)))

;; load configuration settings by type
(jeg2/load-init-file "jeg2/init/freshen")
(jeg2/load-init-file "jeg2/init/system")
(jeg2/load-init-file "jeg2/init/autoloads")
(jeg2/load-init-file "jeg2/init/packages")
(jeg2/load-init-file "jeg2/init/compile")
(jeg2/load-init-file "jeg2/init/autohooks")
(jeg2/load-init-file "jeg2/init/settings")
