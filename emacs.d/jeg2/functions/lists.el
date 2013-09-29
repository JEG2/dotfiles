;;;###autoload
(defun jeg2/flatten (x)
  "Flatten a list."
  (cond ((null x) nil)
        ((listp x) (append (jeg2/flatten (car x)) (jeg2/flatten (cdr x))))
        (t (list x))))
