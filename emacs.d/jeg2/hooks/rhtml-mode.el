;; enhance character pairing (activated by html-mode)
(sp-with-modes (list major-mode)
  (sp-local-pair "<"   ">")
  (sp-local-tag  "<" "<_>" "</_>" :transform 'sp-match-sgml-tags))
