;; show wrap guide
(require 'fill-column-indicator)
(setq fci-rule-column jeg2-wrap-limit)
(fci-mode)

(local-set-key (kbd "C-c v w") 'fci-mode)

;; show junk whitespace
(whitespace-mode)

;; activate character pairing
(smartparens-mode)

(sp-with-modes (list major-mode)
  (sp-local-pair "'" nil :actions '(:rem insert))
  ;; (sp-local-pair "'" nil :unless '(:add jeg2/sp-in-rust-mode))
  ; pair for generics and lifetimes, but not comparisons
  (sp-local-pair "<" ">" :when '(sp-point-after-word-p)))

;; do some spell checking (requires:  brew install aspell --lang=en)
(flyspell-prog-mode)

(local-set-key (kbd "C-c v s") 'jeg2/toggle-program-spelling)

;; configure compilation
(set (make-local-variable 'compile-command)
     (concat "rustc " buffer-file-name))
(set (make-local-variable 'compilation-read-command)
     nil)

;; command shortcuts
(local-set-key (kbd "C-c c") 'compile)

(local-set-key (kbd "C-M-n") 'jeg2/other-window-next-line)
(local-set-key (kbd "C-M-p") 'jeg2/other-window-previous-line)

(local-set-key (kbd "C-c =") 'jeg2/align=)

(local-set-key (kbd "C-c t s") 'jeg2/toggle-string-type)
