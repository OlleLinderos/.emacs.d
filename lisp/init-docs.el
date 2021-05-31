(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; TODO: Move org mode config here
;; (setq org-default-notes-file (concat org-directory "/notes.org"))

(provide 'init-docs)
