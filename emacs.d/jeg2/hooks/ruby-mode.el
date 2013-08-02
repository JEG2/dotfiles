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
  (sp-local-pair "|" "|"))

;; do some spell checking (requires:  brew install aspell --lang=en)
(flyspell-prog-mode)

(local-set-key (kbd "C-c v s") 'jeg2/toggle-program-spelling)

;; command shortcuts
(local-set-key (kbd "C-c =") 'jeg2/align=)

(local-set-key (kbd "C-c t s") 'jeg2/toggle-string-type)

(local-set-key (kbd "C-c t t") 'jeg2/toggle-ruby-test)
(local-set-key (kbd "C-c t b") 'jeg2/toggle-ruby-block-type)
(local-set-key (kbd "C-c t r") 'jeg2/toggle-ruby-regex-type)
(local-set-key (kbd "C-c t S") 'jeg2/toggle-ruby-string-and-symbol)
(local-set-key (kbd "C-c t h") 'jeg2/toggle-ruby-hash-type)
