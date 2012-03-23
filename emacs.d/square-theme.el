(deftheme square "Created 2012-03-15.")

(custom-theme-set-faces
 'square
 '(escape-glyph ((t (:foreground "red"))))
 '(minibuffer-prompt ((t (:foreground "blue"))))
 '(highlight ((t (:background "green" :foreground "black"))))
 '(region ((t (:background "cyan" :foreground "black" :weight bold))))
 '(shadow ((t (:background "black" :foreground "green"))))
 '(secondary-selection ((t (:background "cyan" :foreground "magenta"))))
 '(trailing-whitespace ((t (:background "red"))))
 '(font-lock-builtin-face ((t (:foreground "blue" :weight bold))))
 '(font-lock-comment-delimiter-face ((t (:foreground "red"))))
 '(font-lock-comment-face ((t (:foreground "red"))))
 '(font-lock-constant-face ((t (:foreground "magenta"))))
 '(font-lock-doc-face ((t (:foreground "green"))))
 '(font-lock-function-name-face ((t (:foreground "blue" :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "cyan" :weight bold))))
 '(font-lock-preprocessor-face ((t (:foreground "blue"))))
 '(font-lock-regexp-grouping-backslash ((t
                                         (:foreground "yellow" :weight bold))))
 '(font-lock-regexp-grouping-construct ((t
                                         (:foreground "yellow" :weight bold))))
 '(font-lock-string-face ((t (:foreground "green" :weight bold))))
 '(font-lock-type-face ((t (:foreground "green"))))
 '(font-lock-variable-name-face ((t (:foreground "yellow"))))
 '(font-lock-warning-face ((t (:foreground "red")))))

(provide-theme 'square)