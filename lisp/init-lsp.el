(use-package lsp-mode
  :config
  (setq lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting t
        lsp-enable-snippet nil)
  :hook
  ((c++-mode . lsp)
   (haskell-mode . lsp)
   (ruby-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration)))

(use-package lsp-ui
  :config (setq lsp-ui-sideline-show-hover t
                lsp-ui-sideline-delay 0.1
                lsp-ui-doc-delay 5
                lsp-ui-sideline-ignore-duplicates t
                lsp-ui-doc-position 'bottom
                lsp-ui-doc-alignment 'frame
                lsp-ui-doc-header nil
                lsp-ui-doc-include-signature t
                lsp-ui-doc-use-childframe t)
  :bind (:map evil-normal-state-map
              ("gd" . lsp-open)
              ("gr" . lsp-ui-peek-find-references))
  :commands lsp-ui-mode)

;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(provide 'init-lsp)
