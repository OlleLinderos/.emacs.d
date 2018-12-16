;;(use-package haskell)
;;(require 'haskell)

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(use-package company-ghc)
(require 'company-ghc)
(add-to-list 'company-backends 'company-ghc)

(use-package flycheck-haskell)
(require 'flycheck-haskell)
(add-hook 'haskell-mode-hook #'flycheck-haskell-setup)

;;(add-to-list 'load-path "~/lib/emacs/haskell-mode/")
;; (require 'haskell-mode-autoloads)
;;(add-to-list 'Info-default-directory-list "~/lib/emacs/haskell-mode/")


(provide 'haskell-setup)
