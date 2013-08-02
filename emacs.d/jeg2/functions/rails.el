;;;###autoload
(defun jeg2/read-rails-database-config (path)
  "Loads the database config as:  adapter database username [password]."
  (split-string
   (shell-command-to-string
    (concat "ruby -ryaml -rerb -e 'puts YAML.load(ERB.new(ARGF.read).result)[%q{"
            (or (getenv "RAILS_ENV") "development")
            "}].values_at(*%w[adapter database username password])"
            ".compact.join(%q{ })' "
            path))))
