(use-package elixir-mode
  :hook
  (lambda ()
   (lsp-de)
   (flycheck-mode)))

(provide 'init-elixir)
