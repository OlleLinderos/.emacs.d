(use-package emmet-mode)
(use-package sass-mode)
  
(defun setup-web-mode ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (set (make-local-variable 'company-backends) '(company-web-html)))

(use-package web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-hook 'web-mode-hook 'setup-web-mode)
  (add-hook 'web-mode-hook 'emmet-mode))

(provide 'web-setup)
