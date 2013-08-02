(require 'cl-macs)

;;;###autoload
(defun jeg2/toggle-ruby-test ()
  "Toggler between positive and negative assertions."
  (interactive)
  (let ((bound (save-excursion (unless (bolp) (move-beginning-of-line nil))
                               (point))))
    (if (search-backward "refute" bound t)
        (replace-match "assert")
      (if (search-backward "assert" bound t)
          (replace-match "refute")
        (if (search-backward "wont" bound t)
            (replace-match "must")
          (if (search-backward "must" bound t)
              (replace-match "wont")
            (if (search-backward "not_to" bound t)
                (replace-match "to")
              (if (search-backward "to" bound t)
                  (replace-match "not_to")))))))))

;;;###autoload
(defun jeg2/toggle-ruby-block-type ()
  "Toggle between brace and do/end block types."
  (interactive)
  (let ((regex (concat "\\`\\(?:"
                       "{.*}"
                       "\\|"
                       "do\\b.+\\bend"
                       "\\)\\'")))
    (while (or (not (region-active-p))
               (not (or (and (= (point-min) (region-beginning))
                             (= (point-max) (region-end)))
                        (string-match regex (buffer-substring-no-properties
                                             (region-beginning)
                                             (region-end))))))
      (let ((expand-region-fast-keys-enabled))
        (er/expand-region 1)))
    (let ((matched (buffer-substring-no-properties (region-beginning)
                                                   (region-end))))
      (if (string-match regex matched)
          (cond ((string= (substring matched 0 1) "{")
                 (let ((lines (split-string
                               (concat "do"
                                       (if (= (count-matches "\n"
                                                             (point)
                                                             (mark)) 0)
                                           (substring
                                            (jeg2/regex-replace
                                             (jeg2/regex-replace
                                              matched
                                              "\\`\\({\\(?:\s*|[^|]*|\\)?\\)\s*"
                                              "\\1\n")
                                             "\s*}\\'"
                                             "\n}")
                                            1
                                            -1)
                                         (substring matched 1 -1))
                                       "end")
                               "\n")))
                   (call-interactively 'backward-delete-char-untabify)
                   (cl-loop for line in lines do
                            (unless (string= line (car lines)) (newline))
                            (insert line))
                   (indent-for-tab-command)
                   (previous-line)
                   (unless (eolp) (move-end-of-line nil))
                   (indent-for-tab-command)))
                ((string= (substring matched 0 2) "do")
                 ; FIXME:  need to fix expand-region or use a different trick
                 ))))))

;;;###autoload
(defun jeg2/toggle-ruby-regex-type ()
  "Toggle between standard and choose-your-own-quotes regex types."
  (interactive)
  (let ((regex (concat "\\`\\(?:"
                       "/\\(?:\\\\\\\\\\|\\\\\.\\|[^/\\]+\\)*/"
                       "\\|"
                       "%r{.*}" ; FIXME:  sometimes fails
                       "\\|"
                       "{.*}"
                       "\\)\\'")))
    (while (or (not (region-active-p))
               (not (or (and (= (point-min) (region-beginning))
                             (= (point-max) (region-end)))
                        (string-match regex (buffer-substring-no-properties
                                             (region-beginning)
                                             (region-end))))))
      (let ((expand-region-fast-keys-enabled))
        (er/expand-region 1)))
    (let ((matched (buffer-substring-no-properties (region-beginning)
                                                   (region-end))))
      (if (string-match regex matched)
          (cond ((string= (substring matched 0 1) "/")
                 (call-interactively 'backward-delete-char-untabify)
                 (let ((old_point (point)))
                   (insert (concat "%r{"
                                   (jeg2/regex-replace-all
                                    (substring matched 1 -1)
                                    "\\\\/"
                                    "/")
                                   "}"))
                   (goto-char (+ old_point 3))))
                ((string= (substring matched 0 1) "{")
                 (call-interactively 'backward-delete-char-untabify)
                 (call-interactively 'backward-delete-char-untabify)
                 (call-interactively 'backward-delete-char-untabify)
                 (let ((old_point (point)))
                   (insert (concat "/"
                                   (jeg2/regex-replace (substring matched 1 -1)
                                                       "/"
                                                       "\\\\/")
                                   "/"))
                   (goto-char (+ old_point 1))))
                ((string= (substring matched 0 3) "%r{")
                 (call-interactively 'backward-delete-char-untabify)
                 (let ((old_point (point)))
                   (insert (concat "/"
                                   (jeg2/regex-replace (substring matched 3 -1)
                                                       "/"
                                                       "\\\\/")
                                   "/"))
                   (goto-char (+ old_point 1)))))))))

;;;###autoload
(defun jeg2/toggle-ruby-string-and-symbol ()
  "Toggle between strings and symbols."
  (interactive)
  (let ((regex (concat "\\`\\(?:"
                       "\"\\(?:\\\\\\\\\\|\\\\\.\\|[^\"\\]+\\)*\""
                       "\\|"
                       "'\\(?:\\\\\\\\\\|\\\\\.\\|[^'\\]+\\)*'"
                       "\\|"
                       ":\\w+"
                       "\\)\\'")))
    (while (or (not (region-active-p))
               (not (or (and (= (point-min) (region-beginning))
                             (= (point-max) (region-end)))
                        (string-match regex (buffer-substring-no-properties
                                             (region-beginning)
                                             (region-end))))))
      (let ((expand-region-fast-keys-enabled))
        (er/expand-region 1)))
    (let ((matched (buffer-substring-no-properties (region-beginning)
                                                   (region-end))))
      (if (string-match regex matched)
          (cond ((or (string= (substring matched 0 1) "\"")
                     (string= (substring matched 0 1) "'"))
                 (call-interactively 'backward-delete-char-untabify)
                 (let ((old_point (point)))
                   (insert (concat ":" (substring matched 1 -1)))
                   (goto-char (+ old_point 1))))
                ((string= (substring matched 0 1) ":")
                 (call-interactively 'backward-delete-char-untabify)
                 (let ((old_point (point)))
                   (insert (concat "\"" (substring matched 1) "\""))
                   (goto-char (+ old_point 1)))))))))

;;;###autoload
(defun jeg2/toggle-ruby-hash-type ()
  "Toggle between symbol key hash types."
  (interactive)
  (while (and (not
               (looking-at
                "\\(?::[A-Za-z0-9_]+\s*=>\\|[^A-Za-z0-9_][A-Za-z0-9_]+:\\)"))
              (> (point) (point-min)))
    (backward-char))
  (if (looking-at ":[A-Za-z0-9_]+\s*=>")
      (progn (delete-char 1)
             (while (not (looking-at "\s*=>")) (forward-word))
             (while (looking-at "\s") (delete-char 1))
             (delete-char 2)
             (insert ":")
             (backward-char 2))
    (forward-char)
    (insert ":")
    (let ((end_point (point)))
      (while (not (looking-at ":")) (forward-word))
      (delete-char 1)
      (insert " =>")
      (goto-char end_point))))
