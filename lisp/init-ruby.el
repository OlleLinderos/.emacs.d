(use-package ruby-mode
  :after lsp-mode
  :hook ((ruby-mode . lsp-deferred)
         (ruby-mode . amk-lsp-format-on-save)))
  ;;:ensure-system-package (solargraph . "gem install --user-install solargraph")

(setq lsp-solargraph-use-bundler t)

(provide 'init-ruby)
