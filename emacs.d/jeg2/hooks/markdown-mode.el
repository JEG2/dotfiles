;; show wrap guide and use soft wrap
(require 'fill-column-indicator)
(setq fci-rule-column jeg2-wrap-limit)
(fci-mode)

(setq fill-column jeg2-wrap-limit)
(longlines-mode)

(local-set-key (kbd "C-c v w") 'jeg2/toggle-wrap)

;; show junk whitespace
(whitespace-mode)

;; activate character pairing
(smartparens-mode)

(sp-with-modes (list major-mode)
  (sp-local-pair "`" "`"))

;; command shortcuts
(local-set-key (kbd "C-c y")   'jeg2/markdown-yank-as-pre)
(local-set-key (kbd "C-c o p") 'jeg2/markdown-preview)

;; limit the spell checking activated by text-mode
(setq flyspell-generic-check-word-predicate 'jeg2/markdown-mode-flyspell-verify)
