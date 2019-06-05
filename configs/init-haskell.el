(use-package haskell-mode
  :pin melpa-stable)

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(use-package company-ghc
  :init
  (add-to-list 'company-backends 'company-ghc))

(use-package flycheck-haskell
  :init
  (add-hook 'haskell-mode-hook #'flycheck-haskell-setup))

(provide 'init-haskell)
