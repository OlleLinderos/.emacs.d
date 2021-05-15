(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.ts\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :init
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)) 
  (set (make-local-variable 'company-backends) '(company-web-html))
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook #'setup-tide-mode)
  :config
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 4
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2
        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t))

(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode #'subword-mode))

(use-package tide
  :init
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(with-eval-after-load 'tide
  (flycheck-add-mode 'typescript-tslint 'ng2-ts-mode)
  (flycheck-add-mode 'typescript-tide 'ng2-ts-mode))

(evil-leader/set-key "j" 'javascript-map)
(progn
  (define-prefix-command 'javascript-map)
  (define-key javascript-map (kbd "a") 'angular-map)
  
  (define-key javascript-map (kbd "d") 'tide-jump-to-definition)
  (define-key javascript-map (kbd "r") 'tide-rename-symbol))

(progn
  (define-prefix-command 'angular-map)
  (define-key angular-map (kbd "c") 'ng2-open-counterpart))


(use-package sass-mode)
(use-package elm-mode)

(provide 'init-web)
