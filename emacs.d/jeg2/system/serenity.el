;; Integrate with Mac OS X's pasteboard.  Inspried by:
;; https://gist.github.com/the-kenny/267162
(defvar jeg2-pbpaste-executable (executable-find "pbpaste")
  "The pbpaste executable")

(defvar jeg2-pbcopy-executable (executable-find "pbcopy")
  "The pbcopy executable")

(defun jeg2/pbpaste ()
  (shell-command-to-string jeg2-pbpaste-executable))

(defun jeg2/pbcopy (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" jeg2-pbcopy-executable)))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function   'jeg2/pbcopy)
(setq interprogram-paste-function 'jeg2/pbpaste)
