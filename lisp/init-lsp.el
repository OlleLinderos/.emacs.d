(use-package lsp-mode
  :config
  (setq lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting t
        lsp-enable-snippet nil)
  (defun amk-lsp-format-buffer-quick ()
    (let ((lsp-response-timeout 2))
      (lsp-format-buffer)))
  (defun amk-lsp-format-on-save ()
    (add-hook 'before-save-hook #'amk-lsp-format-buffer-quick nil t))
  (defun amk-lsp-disable-format-on-save ()
    (remove-hook 'before-save-hook #'amk-lsp-format-buffer-quick t))
  (defun amk-lsp-organize-imports-on-save ()
    (add-hook 'before-save-hook #'lsp-organize-imports nil t))
  :custom
  (lsp-solargraph-multi-root nil)
  :hook
  ((lsp-mode . lsp-enable-which-key-integration)))

(use-package lsp-ui
  :config (setq lsp-ui-sideline-show-hover nil 
                lsp-ui-sideline-delay 0.1
                lsp-ui-doc-delay 5
                lsp-ui-sideline-ignore-duplicates t
                lsp-ui-doc-position 'top
                lsp-ui-doc-alignment 'window
                lsp-ui-doc-header nil
                lsp-ui-doc-include-signature t
                lsp-ui-doc-use-childframe t)
  :bind (:map evil-normal-state-map
              ("gd" . lsp-open)
              ("gr" . lsp-ui-peek-find-references))
  :commands lsp-ui-mode)

(use-package dap-mode)

(provide 'init-lsp)
