(use-package evil
  :init (evil-mode 1)
  :config
  (global-set-key [escape] 'minibuffer-keyboard-quit)
  (setq evil-want-C-u-scroll t)
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-insert-state-map (kbd "C-u")
    (lambda ()
      (interactive)
      (evil-delete (point-at-bol) (point)))))

(use-package evil-leader
  :demand
  :config
  (progn
    (setq evil-leader/in-all-states t)
    (global-evil-leader-mode))
  (evil-leader/set-leader "SPC")
  (evil-leader/set-key
    "/" 'comment-or-uncomment-region
    "a" 'avy-map
    "b" 'buffer-map
    "m" 'text-map
    "e" 'eval-buffer
    "f" 'file-map
    "w" 'evil-window-map))

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

(setq show-paren-delay 0)
(show-paren-mode 1)
(electric-pair-mode t)

(use-package linum-relative
  :init
  (linum-relative-mode)
  (add-hook 'prog-mode-hook 'linum-mode)
  (add-hook 'org-mode-hook 'linum-mode))

(require 'git-gutter-fringe)
(setq-default right-fringe-width 20)
(setq git-gutter-fr:side 'right-fringe)

(use-package hl-todo
  :init
  (global-hl-todo-mode t)
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(provide 'init-editor)