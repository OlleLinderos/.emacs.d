(use-package evil
  :init (evil-mode 1)
  :config (setq evil-want-C-u-scroll t))

(use-package evil-leader
  :demand
  :config
  (progn
    (setq evil-leader/in-all-states t)
    (global-evil-leader-mode)))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-tooltip-align-annotations t
        company-idle-delay t
        company-tooltip-limit 20
        company-tooltip-align-annotations t
        company-begin-commands '(self-insert-command)))

(use-package flycheck)

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package autopair
  :init
  (autopair-global-mode))

(show-paren-mode 1)
(setq show-paren-delay 0)

(provide 'editor)
