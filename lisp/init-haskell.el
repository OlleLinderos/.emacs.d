(use-package lsp-haskell
  ;:ensure-system-package (haskell-language-server-wrapper . "yay -S haskell-language-server-bin")
  :init
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'haskell-literate-mode-hook #'lsp))

(provide 'init-haskell)
