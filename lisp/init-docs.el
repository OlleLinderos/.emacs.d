(use-package org)

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package ob-http)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (http . t)
   (shell . t)
   (python . t)
   (sql . t)))

(setq org-src-window-setup 'current-window)

(bind-key "C-c C-c" 'org-edit-src-exit org-src-mode-map)

(defun org-babel-execute:passthrough (body params) body)
(defalias 'org-babel-execute:json 'org-babel-execute:passthrough)

(use-package org-roam
  :ensure t
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today))
  :init
  (setq org-roam-directory (file-truename "~/Documents/org/")
        org-default-notes-file (concat org-directory "/notes.org")
        org-roam-v2-ack t)
  (org-roam-setup))

(evil-leader/set-key "." 'org-roam-node-find)

(provide 'init-docs)
