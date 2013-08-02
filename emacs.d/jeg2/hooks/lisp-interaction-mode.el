;; configure sexp editor
(require 'paredit)
(paredit-mode)

(local-set-key (kbd "C-c f") 'paredit-forward-slurp-sexp)
(local-set-key (kbd "C-c F") 'paredit-forward-barf-sexp)
