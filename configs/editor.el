(use-package evil
  :init (evil-mode 1)
  :config (setq evil-want-C-u-scroll t))

(use-package evil-leader
  :demand
  :config
  (progn
    (setq evil-leader/in-all-states t)
    (global-evil-leader-mode)))

(use-package evil-mc
  :init
  (evil-mc-mode 1))

(use-package company
  :config
  (define-key company-active-map (kbd "C-q") 'company-select-previous)
  (define-key company-active-map (kbd "C-w") 'company-select-next)
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-tooltip-align-annotations t
        company-idle-delay t
        company-tooltip-limit 20
        company-tooltip-align-annotations t
        company-begin-commands '(self-insert-command)))

(use-package company-quickhelp
  :ensure t
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip
    :ensure t))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'typescript-mode-hook 'flycheck-mode))

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package autopair
  :init
  (autopair-global-mode))

(show-paren-mode 1)
(setq show-paren-delay 0)

;; (use-package yasnippet
;;   :init
;;   (yas-global-mode 1))

;; (use-package yasnippet-snippets)

(provide 'editor)
