;; restrict spelling
(setq jeg2-spelling-skipped-markdown-faces
      '(markdown-pre-face markdown-reference-face markdown-url-face))

(defun jeg2/markdown-mode-flyspell-verify ()
  "An override used to shut Flyspell of in some parts of Markdown."
  (let ((face (get-text-property (point) 'face)))
    (not (memq face jeg2-spelling-skipped-markdown-faces))))
