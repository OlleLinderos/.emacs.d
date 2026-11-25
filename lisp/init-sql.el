;;; -*- lexical-binding: t; -*-

(use-package sql-indent
  :hook (sql-mode . sqlind-minor-mode))

(add-hook 'sql-mode-hook #'lsp-deferred)

;; shush
(with-eval-after-load 'lsp-sql
  (dolist (id '(sql-ls sql-ls-tramp))
    (when-let* ((client (gethash id lsp-clients)))
      (puthash "sqlLanguageServer.finishSetup" #'ignore
               (lsp--client-notification-handlers client)))))

(provide 'init-sql)
