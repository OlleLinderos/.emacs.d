(use-package perspective
  :config
  (persp-mode))

(use-package projectile
  :init
  (setq projectile-indexing-method 'native)
  (setq projectile-enable-caching t)
  (setq projectile-globally-ignored-directories
        '("node_modules/"
          ".yarn/"
          "bower_components/"
          "vendor/"
          ".idea/"
          "out/"
          "resources/out/"
          "target/"
          ".git/"
          "dist/"
          ".cljs_nashorn_repl"
          ".stack-work/"
          ".shadow-cljs/"
          ".tmp/"))
  (projectile-mode))

(use-package persp-projectile)

(use-package winum
  :init (winum-mode))

(use-package magit
  :init
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(use-package ag)

(use-package neotree
  :init
  (setq neo-theme 'icons
        neo-smart-open t)
  (setq-default neo-show-hidden-files t)
  (setq neo-window-fixed-size nil
        neo-window-width 50)
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))

(defun open-neotree ()
  (interactive)
  (neotree-projectile-action))

(use-package linum-relative
  :init
  (linum-relative-mode)
  (add-hook 'prog-mode-hook 'linum-mode)
  (add-hook 'org-mode-hook 'linum-mode))

(provide 'workflow)
