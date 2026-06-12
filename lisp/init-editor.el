(use-package corfu
  :init
  (setq corfu-auto t
        corfu-auto-delay 0.2
        corfu-auto-prefix 1
        corfu-cycle t
        corfu-count 20
        corfu-quit-no-match 'separator)
  :hook (after-init . global-corfu-mode)
  :config
  (corfu-popupinfo-mode 1))

(use-package flycheck
  :defer t)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package highlight-parentheses
  :init
  (setq highlight-parentheses-colors
        '("#f5a97f" "IndianRed1" "IndianRed3" "IndianRed4")
        highlight-parentheses-attributes
        '((:weight ultra-bold) (:weight bold)))
  :hook (prog-mode . highlight-parentheses-mode))

(setq show-paren-delay 0)
(show-paren-mode 1)
(electric-pair-mode 1)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)

(use-package hl-todo
  :init
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold)))
  :config
  (global-hl-todo-mode 1))

;; detect current file indent settings and use those
(use-package dtrt-indent
  :config
  (dtrt-indent-global-mode 1))

(provide 'init-editor)
