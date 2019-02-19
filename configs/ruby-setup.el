(use-package enh-ruby-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode)))

;; Robe Mode? :D
;; (use-package robe
;;   :init
;;   (add-hook 'ruby-mode-hook 'enh-ruby-mode))

;; (eval-after-load 'company
;;   '(push 'company-robe company-backends))

(provide 'ruby-setup)
