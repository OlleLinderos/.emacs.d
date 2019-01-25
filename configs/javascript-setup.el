(use-package tide
  :ensure
  :config
  (setq tide-format-options '(:indentSize 2)
        typescript-indent-level 2))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;;(flycheck-add-mode 'typescript-tslint 'ng2-ts-mode)
;;(flycheck-add-mode 'typescript-tide 'ng2-ts-mode)

(use-package ng2-mode
  :ensure)

(use-package js2-mode
  :config
  (setq javascript-indent-level 2))
 
(use-package company-tern)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (setq js2-basic-offset 2)
                           (tern-mode)
                           (company-mode)))

(provide 'javascript-setup)
