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

(use-package magit)

(use-package kubernetes-evil
  :ensure t
  :after kubernetes)

(use-package docker
  :bind ("C-c d" . docker))

(use-package ag)

(use-package neotree
  :init
  (setq neo-theme 'icons)
  (setq neo-window-width 40)
  (setq neo-smart-open t)
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))

(defun open-neotree ()
  (interactive)
  (evil-window-top)
  (neotree-projectile-action))

(use-package linum-relative
  :init
  (linum-relative-mode)
  (add-hook 'prog-mode-hook 'linum-mode)
  (add-hook 'org-mode-hook 'linum-mode))

(use-package git-gutter)
(require 'git-gutter)
(use-package git-gutter-fringe)
(require 'git-gutter-fringe)
(global-git-gutter-mode)
(setq-default right-fringe-width 20)
(setq git-gutter-fr:side 'right-fringe)

(provide 'workflow)
