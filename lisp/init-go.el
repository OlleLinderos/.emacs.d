(use-package go-mode
  :hook ((go-mode . (lambda () (add-hook 'before-save-hook #'gofmt-before-save nil t)))
         (go-mode . lsp-deferred))
  :ensure-system-package (go (gopls . "GO111MODULE=on go get golang.org/x/tools/gopls@latest")))

(require 'dap-go)

(dap-register-debug-template
  "Launch Executable"
  (list :type "go"
        :request "launch"
        :name "Launch Executable"
        :mode "exec"
        :program "dlv"
        :args ""
        :env nil
        :envFile nil))

(dap-go-setup)

(provide 'init-go)
