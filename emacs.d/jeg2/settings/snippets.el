(setq yas-snippet-dirs
      (list (expand-file-name "jeg2/snippets" user-emacs-directory)
            ))

(yas-global-mode)

(setq yas-prompt-functions '(yas/ido-prompt))
