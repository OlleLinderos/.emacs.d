;;
;; Web
;;

;; Generate HTML
(use-package emmet-mode)
(require 'emmet-mode)

(use-package web-mode)
(require 'web-mode)

(use-package sass-mode)
(require 'sass-mode)

(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun setup-web-mode ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (set (make-local-variable 'company-backends) '(company-web-html)))

(add-hook 'web-mode-hook 'setup-web-mode)
(add-hook 'web-mode-hook 'emmet-mode)


(provide 'web)
