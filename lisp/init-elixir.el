(use-package elixir-mode
  :hook
  (elixir-mode . flycheck-mode)
  (elixir-mode . lsp-deferred))

(provide 'init-elixir)
