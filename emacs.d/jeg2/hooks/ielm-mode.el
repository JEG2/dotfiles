;; configure sexp editor
(require 'paredit)
(paredit-mode)

(define-key ielm-map (kbd "C-c f") 'paredit-forward-slurp-sexp)
(define-key ielm-map (kbd "C-c F") 'paredit-forward-barf-sexp)
