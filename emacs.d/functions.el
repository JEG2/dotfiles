;;;;;;;;;;;;;;;;;
;;; Functions ;;;
;;;;;;;;;;;;;;;;;

(defun jeg2s-regex-replace (str regex replacement &optional fixedcase literal)
  "Replace a regular expression in the passed string, if it occurs."
  (or (when (string-match regex str)
        (replace-match replacement fixedcase literal str))
      str))

(defun jeg2s-regex-replace-all (str regex replacement &optional fixedcase literal)
  "Replace a regular expression everywhere it occurs in the passed string."
  (if (string-match regex str)
    (jeg2s-regex-replace-all (replace-match replacement fixedcase literal str)
                             regex replacement fixedcase literal)
    str))

(defun jeg2s-string-trim (str)
  "Trim whitespace from both ends of the passed string."
  (jeg2s-regex-replace (jeg2s-regex-replace str "[ \t]+$" "" t t)
                       "^[ \t]+" "" t t))

(defun jeg2s-camelize (str)
  "Forces a string into CamelCase."
  (mapconcat (lambda (s)
               (if (string-match "[aeiouy]" s)
                   (capitalize s)
                 (upcase s)))
             (split-string str "[^A-Za-z0-9]")
             ""))

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
      (if (= (line-number-at-pos) (count-lines (point-min) (point-max)))
          (progn (call-interactively 'jeg2s-newline-below)
                 (previous-line)))
      (unless (bolp)
        (beginning-of-line))
      (call-interactively 'set-mark-command)
      (next-line))
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
