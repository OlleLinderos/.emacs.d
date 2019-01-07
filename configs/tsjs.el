;;
;; TypeScript
;;
(use-package tide)
(require 'tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(setq company-tooltip-align-annotations t)
(setq tide-format-options '(:indentSize 2))
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

(use-package ng2-mode)
(require 'ng2-mode)

(flycheck-add-mode 'typescript-tslint 'ng2-ts-mode)
(flycheck-add-mode 'typescript-tide 'ng2-ts-mode)

(setq typescript-indent-level 2)
(setq javascript-indent-level 2)


;;
;; JavaScript
;;

(use-package js2-mode)
(require 'js2-mode)
 
(use-package company-tern)
(require 'company-tern)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (setq js2-basic-offset 2)
                           (tern-mode)
                           (company-mode)))


(provide 'tsjs)
