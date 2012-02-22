(defun jeg2s-regex-replace (str regex replacement &optional fixedcase literal)
  "Replace a regular expression in the passed string, if it occurs."
  (or (when (string-match regex str)
	(replace-match replacement fixedcase literal str))
      str))

(defun jeg2s-regex-replace-all (str regex replacement &optional fixedcase literal)
  "Replace a regular expression everywhere it occurs in the passed string."
  (if (string-match regex str)
    (jeg2s-regex-replace-all (replace-match replacement fixedcase literal str)
			     regex replacement fixedcase literal)
    str))

(defun jeg2s-string-trim (str)
  "Trim whitespace from both ends of the passed string."
  (jeg2s-regex-replace (jeg2s-regex-replace str "[ \t]+$" "" t t) "^[ \t]+" "" t t))
