(use-package nim-mode
  :ensure t
  :hook
  (nim-mode . lsp))

;; (add-to-list 'lsp-language-id-configuration '(nim-mode . "nim"))
;; (lsp-register-client
;;  (make-lsp-client :new-connection (lsp-stdio-connection "nimlsp")
;;                   :major-modes '(nim-mode)
;;                   :server-id 'nimlsp))

(provide 'init-nim)
