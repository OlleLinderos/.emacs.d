(use-package projectile
  :init
  (setq projectile-indexing-method 'native)
  (setq projectile-enable-caching t)
  (setq projectile-globally-ignored-directories
        '("node_modules/"
          "bower_components/"
          "vendor/"
          ".git/"
          "dist/"
          ".tmp/"))
  (projectile-mode))

(use-package perspective
  :init
  (persp-mode))

(use-package persp-projectile)

(use-package winum
  :init (winum-mode))

(use-package magit)

(use-package kubernetes-evil
  :ensure t
  :after kubernetes)

(use-package docker
  :bind ("C-c d" . docker))

(use-package ag)

(use-package neotree
  :init
  (setq neo-theme 'icons
        neo-window-width 40
        neo-smart-open t)
  (setq-default neo-show-hidden-files t)
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))

(defun open-neotree ()
  (interactive)
  (winum-select-window-1)
  (neotree-projectile-action))

(use-package linum-relative
  :init
  (linum-relative-mode)
  (add-hook 'prog-mode-hook 'linum-mode)
  (add-hook 'org-mode-hook 'linum-mode))

(use-package multi-term
  :config
  (setq multi-term-program "/bin/zsh"
        multi-term-dedicated-window-height 18
        multi-term-dedicated-max-window-height 18))

(defun toggle-terminal ()
  (interactive)
  (multi-term-dedicated-toggle)
  (multi-term-dedicated-select))

;; ugh whats up with this
(use-package git-gutter)
(require 'git-gutter)
(use-package git-gutter-fringe)
(require 'git-gutter-fringe)
(global-git-gutter-mode)
(setq-default right-fringe-width 20)
(setq git-gutter-fr:side 'right-fringe)

(provide 'workflow)
