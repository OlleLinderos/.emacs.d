(use-package emmet-mode)
(use-package sass-mode)
(use-package elm-mode)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
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
  (set (make-local-variable 'company-backends) '(company-web-html))
  (add-hook 'web-mode-hook 'emmet-mode)
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2

        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t)
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
		(setup-tide-mode))))
  ;; enable typescript-tslint checker
  (flycheck-add-mode 'typescript-tslint 'web-mode))

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

(use-package ng2-mode
  :ensure)

(use-package js2-mode
  :ensure t
  :interpreter (("node" . js2-mode))
  :bind (:map js2-mode-map ("C-c C-p" . js2-print-json-path))
  :mode "\\.\\(js\\|json\\)$"
  :config
  (add-hook 'js-mode-hook 'js2-minor-mode)
  (setq js2-basic-offset 2
        js2-highlight-level 3
        js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil))


(use-package auto-complete
  :diminish auto-complete-mode
  :ensure t
  :config
  (use-package auto-complete-config)
  (ac-config-default)
  (add-to-list 'ac-modes 'html-mode)
  (setq ac-use-menu-map t)
  (ac-set-trigger-key "TAB")
  (ac-set-trigger-key "<tab>"))

(use-package ac-js2
  :defer t
  :ensure t
  :init
  (add-hook 'js2-mode-hook 'ac-js2-mode)
  (setq ac-js2-evaluate-calls t))

(progn
  (define-prefix-command 'javascript-map)
  (define-key javascript-map (kbd "a") 'angular-map)
  (define-key javascript-map (kbd "t") 'tide-map))

(progn
  (define-prefix-command 'tide-map)
  (define-key tide-map (kbd "d") 'tide-jump-to-definition)
  (define-key tide-map (kbd "r") 'tide-rename-symbol))

(progn
  (define-prefix-command 'angular-map)
  (define-key angular-map (kbd "c") 'ng2-open-counterpart))


(provide 'init-web)
