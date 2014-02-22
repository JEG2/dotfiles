;; shut off the scratch buffer (I use ielm when needed)
(kill-buffer "*scratch*")

;; update buffers when the associated file changes
(global-auto-revert-mode t)

;; use the directory when buffer names clash
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
