;;;###autoload
(defun jeg2/sp-in-rust-mode (id action context)
  "Returns true if Rust code."
  (equal major-mode 'rust-mode))
