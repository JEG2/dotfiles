(require 'cl)

;;;;;;;;;;;;;;;;;
;;; Functions ;;;
;;;;;;;;;;;;;;;;;

(defun jeg2s-regex-replace (str regex replacement &optional fixedcase literal)
  "Replace a regular expression in the passed string, if it occurs."
  (or (when (string-match regex str)
        (replace-match replacement fixedcase literal str))
      str))

(defun jeg2s-regex-replace-all (str
                                regex
                                replacement
                                &optional
                                fixedcase
                                literal)
  "Replace a regular expression everywhere it occurs in the passed string."
  (if (string-match regex str)
      (concat (replace-match replacement
                             fixedcase
                             literal
                             (substring str 0 (match-end 0)))
              (jeg2s-regex-replace-all (substring str (match-end 0))
                                       regex
                                       replacement
                                       fixedcase
                                       literal))
    str))

(defun jeg2s-string-trim (str)
  "Trim whitespace from both ends of the passed string."
  (jeg2s-regex-replace (jeg2s-regex-replace str "[ \t]+\\'" "" t t)
                       "\\`[ \t]+" "" t t))

(defun jeg2s-camelize (str)
  "Forces a string into CamelCase."
  (mapconcat (lambda (s)
               (if (string-match "[aeiouy]" s)
                   (capitalize s)
                 (upcase s)))
             (split-string str "[^A-Za-z0-9]")
             ""))

(defun jeg2s-find-subpath-in-path (subpath path)
  "Walks up the passed path hunting for subpath at each level."
  (let ((match (concat (file-name-as-directory path) subpath)))
    (if (file-exists-p match)
        match
      (unless (string= path "/")
        (jeg2s-find-subpath-in-path
         subpath
         (file-name-directory (substring path 0 -1)))))))

(defun jeg2s-find-in-path (subpath)
  "Walks up the current path hunting for subpath at each level."
  (jeg2s-find-subpath-in-path
   subpath
   (expand-file-name (if (buffer-file-name)
                         (file-name-directory (buffer-file-name))
                       default-directory))))

(defun jeg2s-read-rails-database-config (path)
  "Loads the database config as:  adapter database username [password]."
  (split-string
   (shell-command-to-string
    (concat "ruby -ryaml -rerb -e 'puts YAML.load(ARGF)[%q{"
            (or (getenv "RAILS_ENV") "development")
            "}].values_at(*%w[adapter database username password])"
            ".compact.join(%q{ })' "
            path))))

;;;;;;;;;;;;;;;;
;;; Commands ;;;
;;;;;;;;;;;;;;;;

(defun jeg2s-insert-header-comment ()
  "Inserts a header wrapped in the appropriate comment characters."
  (interactive)
  (let ((header))
    (if (region-active-p)
        (let ((start (region-beginning))
              (end   (region-end)))
          (goto-char start)
          (setq header (buffer-substring start end))
          (message header)
          (delete-region start end))
      (setq header (read-from-minibuffer "Header: ")))
    (let* ((ender (jeg2s-string-trim (or comment-end "")))
           (starter (jeg2s-string-trim (or comment-start "#")))
           (starter-tail (string-to-char (substring starter -1)))
           (indent-size (length
                         (jeg2s-regex-replace
                          starter
                          (concat "\\(" (regexp-quote
                                         (char-to-string starter-tail))
                                  "\\)+$") "")))
           (outdent-size (length (jeg2s-regex-replace
                                  ender
                                  (concat "^\\("
                                          (regexp-quote
                                           (char-to-string starter-tail))
                                          "\\)+") ""))))
      (if (let ((case-fold-search)) (string-match "^[a-z]" header))
          (progn
            ;; first line
            (insert (concat
                     starter
                     (make-string (- (length header)
                                     (length starter)) starter-tail)))
            (newline)
            ;; middle line
            (insert header)
            (newline)
            ;; last line
            (insert (concat
                     (make-string (- (length header)
                                     (length ender))
                                  (string-to-char (substring starter -1)))
                     ender)))
        (progn
          ;; first line
          (insert (concat
                   starter
                   (make-string (- (+ (length header) 8)
                                   (length starter) outdent-size)
                                starter-tail)))
          (newline)
          ;; middle line
          (insert (concat
                   (make-string (- 3 indent-size) starter-tail)
                   " "
                   header
                   " "
                   (make-string (- 3 outdent-size) starter-tail)))
          (indent-for-tab-command)
          (newline)
          ;; last line
          (insert (concat
                   (make-string (- (+ (length header) 8)
                                   indent-size (length ender))
                                (string-to-char (substring starter -1)))
                   ender))
          (indent-for-tab-command))))))
(global-set-key (kbd "C-c ;") 'jeg2s-insert-header-comment)

(defun jeg2s-newline-below (skip-eol)
  "Insert a new line below the current line and indent it."
  (interactive "P")
  (unless (or (eolp) skip-eol)
    (end-of-line))
  (newline-and-indent))
(global-set-key (kbd "C-c l") 'jeg2s-newline-below)
(defun jeg2s-newline-above ()
  "Insert a new line above the current line and indent it."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (previous-line)
  (indent-according-to-mode))
(global-set-key (kbd "C-c L") 'jeg2s-newline-above)

(defun jeg2s-duplicate-line-or-region ()
  "Duplicate the current region, or line, and leave it selected."
  (interactive)
  (let (deactivate-mark)
    (unless (region-active-p)
      (if (and (= 1 (line-number-at-pos))
               (= 1 (count-lines (point-min) (point-max))))
          (progn (call-interactively 'jeg2s-newline-below)
                 (previous-line)))
      (unless (bolp)
        (beginning-of-line))
      (call-interactively 'set-mark-command)
      (next-line)
      (unless (bolp)
        (beginning-of-line)))
    (call-interactively 'kill-region)
    (yank)
    (yank)
    ;; I would prefer to use (activate-mark) below, but it fails in the
    ;; starting case of an unselected line
    (kmacro-exec-ring-item (quote ("" 0 "%d")) nil)))
(global-set-key (kbd "C-c d") 'jeg2s-duplicate-line-or-region)

(defun jeg2s-erc-connect ()
  "Prompts for a channel, then connects to IRC."
  (interactive)
  (erc :server    "irc.freenode.net"
       :port      6667
       :nick      "JEG2"
       :password  freenode-password
       :full-name "James Edward Gray II"))
(global-set-key (kbd "C-c o i") 'jeg2s-erc-connect)

(defun jeg2s-toggle-string-type ()
  "Toggle between double, single, and choose-your-own-quotes string types."
  (interactive)
  (let ((regex (concat "\\`\\(?:"
                       "\"\\(?:\\\\\\\\\\|\\\\\.\\|[^\"\\]+\\)*\""
                       "\\|"
                       "'\\(?:\\\\\\\\\\|\\\\\.\\|[^'\\]+\\)*'"
                       "\\|"
                       "%Q{.*}"
                       "\\)\\'")))
    (while (or (not (region-active-p))
               (not (or (and (= (point-min) (region-beginning))
                             (= (point-max) (region-end)))
                        (string-match regex (buffer-substring-no-properties
                                             (region-beginning)
                                             (region-end))))))
      (call-interactively 'er/expand-region))
    (let ((matched (buffer-substring-no-properties (region-beginning)
                                                   (region-end))))
      (if (string-match regex matched)
          (cond ((string= (substring matched 0 1) "\"")
                 (call-interactively 'backward-delete-char-untabify)
                 (let ((old_point (point)))
                   (insert (concat "%Q{"
                                   (jeg2s-regex-replace-all
                                    (substring matched 1 -1)
                                    "\\\\\""
                                    "\"")
                                   "}"))
                   (goto-char (+ old_point 3))))
                ((string= (substring matched 0 1) "'")
                 (call-interactively 'backward-delete-char-untabify)
                 (let ((old_point (point)))
                   (insert (concat "\""
                                   (jeg2s-regex-replace-all
                                    (jeg2s-regex-replace-all (substring matched
                                                                        1
                                                                        -1)
                                                             "\\\\\'"
                                                             "'")
                                    "\""
                                    "\\\\\"")
                                   "\""))
                   (goto-char (+ old_point 1))))
                ((string= (substring matched 0 3) "%Q{")
                 (call-interactively 'backward-delete-char-untabify)
                 (let ((old_point (point)))
                   (insert (concat "'"
                                   (jeg2s-regex-replace (substring matched 3 -1)
                                                        "'"
                                                        "\\\\'")
                                   "'"))
                   (goto-char (+ old_point 1)))))))))
(global-set-key (kbd "C-c t s") 'jeg2s-toggle-string-type)

(defun jeg2s-toggle-string-and-symbol ()
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
      (call-interactively 'er/expand-region))
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
(global-set-key (kbd "C-c t S") 'jeg2s-toggle-string-and-symbol)

(defun jeg2s-toggle-ruby-block-type ()
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
      (call-interactively 'er/expand-region))
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
                                            (jeg2s-regex-replace
                                             (jeg2s-regex-replace
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
                   (loop for line in lines do
                         (unless (string= line (car lines)) (newline))
                         (insert line))
                   (indent-for-tab-command)
                   (previous-line)
                   (unless (eolp) (move-end-of-line nil))
                   (indent-for-tab-command)))
                ((string= (substring matched 0 2) "do")
                 ;; need to fix expand-region before this can be made to work
                  ))))))
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c t b") 'jeg2s-toggle-ruby-block-type)))

(defun jeg2s-toggle-regex-type ()
  "Toggle between standard and choose-your-own-quotes regex types."
  (interactive)
  (let ((regex (concat "\\`\\(?:"
                       "/\\(?:\\\\\\\\\\|\\\\\.\\|[^/\\]+\\)*/"
                       "\\|"
                       "%r{.*}"
                       "\\|"
                       "{.*}"
                       "\\)\\'")))
    (while (or (not (region-active-p))
               (not (or (and (= (point-min) (region-beginning))
                             (= (point-max) (region-end)))
                        (string-match regex (buffer-substring-no-properties
                                             (region-beginning)
                                             (region-end))))))
      (call-interactively 'er/expand-region))
    (let ((matched (buffer-substring-no-properties (region-beginning)
                                                   (region-end))))
      (if (string-match regex matched)
          (cond ((string= (substring matched 0 1) "/")
                 (call-interactively 'backward-delete-char-untabify)
                 (let ((old_point (point)))
                   (insert (concat "%r{"
                                   (jeg2s-regex-replace-all
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
                                   (jeg2s-regex-replace (substring matched 1 -1)
                                                        "/"
                                                        "\\\\/")
                                   "/"))
                   (goto-char (+ old_point 1))))
                ((string= (substring matched 0 3) "%r{")
                 (call-interactively 'backward-delete-char-untabify)
                 (let ((old_point (point)))
                   (insert (concat "/"
                                   (jeg2s-regex-replace (substring matched 3 -1)
                                                        "/"
                                                        "\\\\/")
                                   "/"))
                   (goto-char (+ old_point 1)))))))))
(global-set-key (kbd "C-c t r") 'jeg2s-toggle-regex-type)

(defun jeg2s-toggle-ruby-hash-type ()
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
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c t h") 'jeg2s-toggle-ruby-hash-type)))

(defun jeg2s-toggle-ruby-test-meaning ()
  "Toggler between positive and negative assertions."
  (interactive)
  (let ((bound (save-excursion (unless (bolp) (move-beginning-of-line nil))
                               (point))))
    (if (search-backward "should_not" bound t)
        (replace-match "should")
      (if (search-backward "should" bound t)
          (replace-match "should_not")
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
                      (replace-match "not_to")))))))))))
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c t t") 'jeg2s-toggle-ruby-test-meaning)))

(require 'sql)
(defun jeg2s-rails-dbconsole ()
  "Open a SQL shell using the settings from config/database.yml."
  (interactive)
  (let ((config (jeg2s-find-in-path "config/database.yml")))
    (if config
        (let* ((env     (jeg2s-read-rails-database-config config))
               (adapter (car env))
               (db      (cond ((string-match "\\`mysql"   adapter)
                               "mysql")
                              ((string-match "\\`sqlite"  adapter)
                               "sqlite")
                              ((string=      "postgresql" adapter)
                               "postgres"))))
          (let ((sql-fun      (intern (concat "sql-" db)))
                (sql-database (cadr   env))
                (sql-user     (caddr  env))
                (sql-password (cadddr env)))
            (flet ((sql-get-login (&rest pars) t))  ; silence confirmation
              (funcall sql-fun)))))))
(global-set-key (kbd "C-c o d") 'jeg2s-rails-dbconsole)

(defun jeg2s-html-insert-open-and-close-tag ()
  "Generates an open and close HTML snippet using the current word."
  (interactive)
  (let ((inserting-new-tag nil))
    (if (looking-back "[-A-Za-z0-9:_]")
        (progn (set-mark-command nil)
               (while (looking-back "[-A-Za-z0-9:_]")
                 (backward-char)))
      (setq inserting-new-tag t)
      (set-mark-command nil)
      (insert "p")
      (exchange-point-and-mark))
    (let ((tag (buffer-substring (region-beginning) (region-end))))
      (delete-char (string-width tag))
      (cond ((string-match "\\`[bh]r\\'" tag)
             (insert (concat "<" tag ">")))
            ((string-match (concat "\\`\\(?:img\\|meta\\|link\\|"
                                   "input\\|base\\|area\\|col\\|"
                                   "frame\\|param\\)\\'")
                           tag)
             (yas/expand-snippet (concat "<" tag " $1>$0")))
            (t
             (yas/expand-snippet
              (if inserting-new-tag
                  (concat "<${1:"
                          tag
                          "}>$0</${1:"
                          "$(and (string-match \"[-A-Za-z0-9:_]+\" text) "
                          "(match-string 0 text))}>")
                (concat "<"
                        tag
                        "$1>$0</"
                        tag
                        ">"))))))))
(global-set-key (kbd "C-c <") 'jeg2s-html-insert-open-and-close-tag)

(defun jeg2s-erb-insert-or-toggle-erb-tag ()
  "Insert an ERb tag if the point isn't currently in one, or toggle the type."
  (interactive)
  (let ((action))
    (save-excursion
      (let ((regex (concat "\\`<%.*%>\\'")))
        (while (or (not (region-active-p))
                   (not (or (and (= (point-min) (region-beginning))
                                 (= (point-max) (region-end)))
                            (string-match regex (buffer-substring-no-properties
                                                 (region-beginning)
                                                 (region-end))))))
          (er/expand-region 1))
        (let ((matched (buffer-substring-no-properties (region-beginning)
                                                       (region-end))))
          (if (string-match regex matched)
              (progn (goto-char (+ (if (< (point) (mark)) (point) (mark)) 2))
                     (cond ((looking-at "=")
                            (delete-char 1))
                           ((looking-at "#")
                            (delete-char 1)
                            (insert "="))
                           (t
                            (insert "#"))))
            (setq action 'insert)))))
    (if (eq action 'insert)
        (progn (insert "<%=  %>")
               (backward-char 3)))))
(global-set-key (kbd "C-c >") 'jeg2s-erb-insert-or-toggle-erb-tag)

(defun jeg2s-nest-new-section ()
  "Splits content before and after the point to insert new content between."
  (interactive)
  (indent-for-tab-command)
  (newline)
  (newline)
  (indent-for-tab-command)
  (previous-line)
  (indent-for-tab-command))
(global-set-key (kbd "C-c RET") 'jeg2s-nest-new-section)
(add-hook 'html-mode-hook  ; override HTML's command
          (lambda ()
            (local-set-key (kbd "C-c RET") 'jeg2s-nest-new-section)))

(defun jeg2s-trim-backwards ()
  "Removes all whitespace behind the point."
  (interactive)
  (while (looking-back "[\s\t\n]")
    (backward-delete-char-untabify 1)))
(global-set-key (kbd "C-c w b") 'jeg2s-trim-backwards)
(defun jeg2s-trim-forwards ()
  "Removes all whitespace in front of the point."
  (interactive)
  (while (looking-at "[\s\t\n]")
    (delete-char 1)))
(global-set-key (kbd "C-c w f") 'jeg2s-trim-forwards)
(defun jeg2s-trim-backwards-and-forwards ()
  "Removes all whitespace behind and in front of the point."
  (interactive)
  (jeg2s-trim-backwards)
  (jeg2s-trim-forwards))
(global-set-key (kbd "C-c w w") 'jeg2s-trim-backwards-and-forwards)
