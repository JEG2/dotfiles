;;;###autoload
(defun jeg2/elixir-module-name ()
  "Guesses a suitable module name from the path."
  (let* ((path (file-name-sans-extension buffer-file-name))
         (dirs (split-string path "/"))
         (lib (member "lib" dirs)))
    (if lib
        (mapconcat 'jeg2/camelize (cdr lib) ".")
      (jeg2/camelize (file-name-nondirectory path)))))
