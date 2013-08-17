;; enhance character pairing (activated by html-mode)
(sp-with-modes (list major-mode)
  (sp-local-pair "<"   ">")
  (sp-local-tag  "<" "<_>" "</_>" :transform 'sp-match-sgml-tags))

;; command shortcuts
(local-set-key (kbd "C-c >") 'jeg2/erb-insert-or-toggle-erb-tag)
