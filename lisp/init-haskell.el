(use-package lsp-haskell
  :hook ((haskell-mode . flycheck-mode)
         (haskell-mode . lsp-deferred)
         (haskell-literate-mode . lsp-deferred)))

(setq haskell-stylish-on-save t)

(defun haskell-mode-format-imports ()
  "Format the imports by aligning and sorting them."
  (interactive)
  (haskell-mode-stylish-buffer))

(provide 'init-haskell)
