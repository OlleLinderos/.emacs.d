;; -*- lexical-binding: t; -*-

(use-package sql-indent
  :hook (sql-mode . sqlind-minor-mode))

(add-hook 'sql-mode-hook #'lsp-deferred)

(provide 'init-sql)
