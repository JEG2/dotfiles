;; use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width        4)
(setq         tab-stop-list    (number-sequence 4 120 4))

;; setup junk whitespace types for when whitespace mode is active
(setq whitespace-style '(face tabs trailing empty))
