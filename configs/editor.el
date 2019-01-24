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
  (setq company-begin-commands '(self-insert-command)))

(use-package agressive-indent)

(use-package )

;; Error checking
(use-package flycheck)
(require 'flycheck)

;; Colored parens
(use-package rainbow-delimiters)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Auto complete parens
(use-package autopair)
(require 'autopair)
(autopair-global-mode)


(provide 'editor)
