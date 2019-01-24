(use-package evil
  :demand
  :config (evil-mode 1)
  :init
  (setq evil-want-C-u-scroll t))

(use-package evil-leader
  :demand
  :config (progn
            (setq evil-leader/in-all-states t)
            (global-evil-leader-mode)))

(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay t)
  (setq company-tooltip-limit 20)
  (setq company-tooltip-align-annotations t)
  (setq company-begin-commands '(self-insert-command)))

(use-package flycheck)

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package autopair
  :init
  (autopair-global-mode))

(provide 'editor)
