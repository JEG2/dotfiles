;; tracking exclusions
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))

;; keep the buffer size reasonable
(setq erc-max-buffer-size 50000)

(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)

(setq erc-truncate-buffer-on-save t)
