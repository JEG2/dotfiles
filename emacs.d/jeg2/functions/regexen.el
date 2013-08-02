;;;###autoload
(defun jeg2/regex-replace (str regex replacement &optional fixedcase literal)
  "Replace a regular expression in the passed string, if it occurs."
  (or (when (string-match regex str)
        (replace-match replacement fixedcase literal str))
      str))

;;;###autoload
(defun jeg2/regex-replace-all (str
                               regex
                               replacement
                               &optional
                               fixedcase
                               literal)
  "Replace a regular expression everywhere it occurs in the passed string."
  (if (string-match regex str)
      (concat (replace-match replacement
                             fixedcase
                             literal
                             (substring str 0 (match-end 0)))
              (jeg2/regex-replace-all (substring str (match-end 0))
                                      regex
                                      replacement
                                      fixedcase
                                      literal))
    str))
