(use-package haskell-mode
  :pin melpa-stable)

;; (use-package company-ghc)

;; (autoload 'ghc-init "ghc" nil t)
;; (autoload 'ghc-debug "ghc" nil t)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; (add-to-list 'company-backends 'company-ghc)
;; (custom-set-variables '(company-ghc-show-info t))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'haskell-font-lock-symbols t)

(put 'downcase-region 'disabled nil)


(evil-leader/set-key "h" 'haskell-map)
(progn
  (define-prefix-command 'haskell-map)
  (define-key haskell-map (kbd "e") 'inferior-haskell-load-and-run))

(provide 'init-haskell)
