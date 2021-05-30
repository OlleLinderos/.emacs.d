;; https://github.com/MaskRay/ccls/wiki

(use-package ccls
  :config
  (setq ccls-executable "ccls"
        lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))


(provide 'init-c-cpp)
