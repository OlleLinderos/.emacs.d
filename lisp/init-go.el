(use-package go-mode
  :defer t
  :hook ((go-mode . (lambda ()
                      (add-hook 'before-save-hook #'gofmt-before-save nil t)))
         (go-mode . lsp-deferred))
  :ensure-system-package (go
                          (gopls . "GO111MODULE=on go get golang.org/x/tools/gopls@latest")))

(provide 'init-go)
