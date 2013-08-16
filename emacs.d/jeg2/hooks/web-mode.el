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
  (sp-local-pair "<"   ">")
  (sp-local-tag  "<" "<_>" "</_>" :transform 'sp-match-sgml-tags))

;; do some spell checking (requires:  brew install aspell --lang=en)
(flyspell-prog-mode)

(local-set-key (kbd "C-c v s") 'jeg2/toggle-program-spelling)

;; command shortcuts
(local-set-key (kbd "C-c RET") 'jeg2/newline-between)  ; an override

(local-set-key (kbd "C-c <") 'jeg2/html-insert-open-and-close-tag)
(local-set-key (kbd "C-c >") 'jeg2/erb-insert-or-toggle-erb-tag)
