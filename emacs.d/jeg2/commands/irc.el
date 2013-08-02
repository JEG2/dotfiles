;;;###autoload
(defun jeg2/erc-connect ()
  "Prompts for a channel, then connects to IRC."
  (interactive)
  (erc :server    "irc.freenode.net"
       :port      6667
       :nick      "JEG2"
       :password  erc-freenode-password
       :full-name "James Edward Gray II"))
