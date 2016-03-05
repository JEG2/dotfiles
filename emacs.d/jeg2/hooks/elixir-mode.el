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
(local-set-key (kbd "C-M-n") 'jeg2/other-window-next-line)
(local-set-key (kbd "C-M-p") 'jeg2/other-window-previous-line)

(local-set-key (kbd "C-c t s") 'jeg2/toggle-string-type)
(local-set-key (kbd "C-c t d") 'jeg2/toggle-elixir-do-blocks)
(local-set-key (kbd "C-c t f") 'jeg2/toggle-elixir-function-syntax)
