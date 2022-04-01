(use-package ccls
  :config
  (setq ccls-executable "ccls"
        lsp-prefer-flymake nil)
  (setq ccls-sem-highlight-method 'font-lock)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))


(provide 'init-c-cpp)
