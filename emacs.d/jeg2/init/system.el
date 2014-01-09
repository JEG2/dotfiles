;; Idea from Ryan Davis:
;; http://blog.zenspider.com/blog/2013/06/my-emacs-setup-osx.html

;; load OS specific settings
(jeg2/load-init-file (concat "jeg2/system/" (symbol-name system-type)) t)

;; load system specific settings
(jeg2/load-init-file (concat "jeg2/system/"
                             (downcase (car (split-string (system-name) "\\."))))
                     t)

;; load minimal early system settings
(jeg2/load-init-file "jeg2/system/minimal.el")
