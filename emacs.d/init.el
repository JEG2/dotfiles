;; JEG2's Emacs configuration

(defun jeg2/load-init-file (path &optional noerror)
  "This loads a file from inside the the .emacs.d directory"
  (let ((file (file-name-sans-extension
               (expand-file-name path user-emacs-directory))))
    (load file noerror)))

;; load configuration settings by type
(jeg2/load-init-file "jeg2/init/freshen.el")
(jeg2/load-init-file "jeg2/init/system.el")
(jeg2/load-init-file "jeg2/init/autoloads.el")
(jeg2/load-init-file "jeg2/init/packages.el")
(jeg2/load-init-file "jeg2/init/compile.el")
(jeg2/load-init-file "jeg2/init/autohooks.el")
(jeg2/load-init-file "jeg2/init/settings.el")
