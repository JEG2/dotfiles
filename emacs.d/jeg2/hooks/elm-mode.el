;; show wrap guide
(require 'fill-column-indicator)
(setq fci-rule-column jeg2-wrap-limit)
(fci-mode)

(local-set-key (kbd "C-c v w") 'fci-mode)

;; show junk whitespace
(whitespace-mode)

;; activate character pairing
(smartparens-mode)

;; do some spell checking (requires:  brew install aspell --lang=en)
(flyspell-prog-mode)

(local-set-key (kbd "C-c v s") 'jeg2/toggle-program-spelling)

;; command shortcuts
(local-unset-key (kbd "C-c RET"))  ; unhide global keybinding

(local-set-key (kbd "C-c =") 'jeg2/align=)

(local-set-key (kbd "C-c t s") 'jeg2/toggle-string-type)
