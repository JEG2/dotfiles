;; shut off the scratch buffer (I use ielm when needed)
(kill-buffer "*scratch*")

;; update buffers when the associated file changes
(global-auto-revert-mode t)
