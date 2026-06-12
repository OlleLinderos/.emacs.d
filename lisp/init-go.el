;;; -*- lexical-binding: t; -*-

(defun mine/lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(when (and (treesit-available-p) (treesit-language-available-p 'go))
  (add-to-list 'major-mode-remap-alist '(go-mode . go-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
  (when (treesit-language-available-p 'gomod)
    (add-to-list 'auto-mode-alist '("/go\\.mod\\'" . go-mod-ts-mode)))
  (add-hook 'go-ts-mode-hook #'lsp-deferred)
  (add-hook 'go-ts-mode-hook #'mine/lsp-go-install-save-hooks))

(provide 'init-go)
