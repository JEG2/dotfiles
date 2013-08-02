;; Idea from Ryan Davis:
;; http://blog.zenspider.com/blog/2013/06/my-emacs-setup-packages.html

(require 'package)

(dolist (repo '(("elpa"      . "http://tromey.com/elpa/")
                ("marmalade" . "http://marmalade-repo.org/packages/")
                ("melpa"     . "http://melpa.milkbox.net/packages/")))
  (add-to-list 'package-archives repo))

(defun jeg2/package-refresh-and-install (name)
  "Ensure we have a fresh package list, then install."
  (package-refresh-contents)
  (package-install name))

(defun jeg2/package-install-unless-installed (name)
  "Install a package by name unless it is already installed."
  (or (package-installed-p name) (jeg2/package-refresh-and-install name)))

(defun jeg2/package-version-for (package)
  "Get the version of a loaded package."
  (package-desc-vers (cdr (assoc package package-alist))))

(defun jeg2/package-delete-by-name (package)
  "Remove a package by name."
  (package-delete (symbol-name package)
                  (package-version-join (jeg2/package-version-for package))))

(defun jeg2/package-delete-unless-listed (packages)
  "Remove packages not explicitly declared."
  (dolist (package (mapcar 'car package-alist))
    (unless (memq package packages) (jeg2/package-delete-by-name package))))

(defun jeg2/package-install-and-remove-to-match-list (&rest packages)
  "Sync packages so the installed list matches the passed list."
  (package-initialize)
  (condition-case nil ;; added to handle no-network situations
      (mapc 'jeg2/package-install-unless-installed packages)
    (error (message "Couldn't install package. No network connection?")))
  (jeg2/package-delete-unless-listed packages))

(jeg2/package-install-and-remove-to-match-list
 'coffee-mode
 'color-theme-sanityinc-tomorrow
 'expand-region
 'dash
 'fill-column-indicator
 'full-ack
 'idomenu
 'inf-ruby
 'magit
 'markdown-mode
 'paredit
 'rainbow-mode
 'rhtml-mode
 'ruby-compilation
 'scss-mode
 'smartparens
 'window-number
 'yagist
 'yaml-mode
 'yasnippet
 )
