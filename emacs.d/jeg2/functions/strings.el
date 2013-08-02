;;;###autoload
(defun jeg2/string-trim (str)
  "Trim whitespace from both ends of the passed string."
  (jeg2/regex-replace (jeg2/regex-replace str "[ \t]+\\'" "" t t)
                      "\\`[ \t]+" "" t t))

;;;###autoload
(defun jeg2/camelize (str)
  "Forces a string into CamelCase."
  (mapconcat (lambda (s)
               (if (string-match "[aeiouy]" s)
                   (capitalize s)
                 (upcase s)))
             (split-string str "[^A-Za-z0-9]")
             ""))
