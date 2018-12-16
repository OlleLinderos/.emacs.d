;;
;; IDE tools
;;

;; Project management
(use-package projectile)
(require 'projectile)
(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)
(setq projectile-globally-ignored-directories '("node_modules/"
                                                "bower_components/"
                                                "vendor/"
                                                ".git/"
                                                "dist/"
                                                ".tmp/"))
(projectile-mode)

;; Workspaces
(use-package perspective)
(require 'perspective)
(persp-mode)

;; Perspective - Projectile integration
(use-package persp-projectile)
(require 'persp-projectile)

;; Git
(use-package magit)
(require 'magit)

;; Kubernetes interfaces
(use-package kubernetes-evil
  :ensure t
  :after kubernetes)
(require 'kubernetes-evil)

;; Docker! 
(use-package docker
  :bind ("C-c d" . docker))
(require 'docker)

;; Silver Searcher
(use-package ag)
(require 'ag)

;; Sidebar treeview
(use-package neotree)
(require 'neotree)
(setq neo-theme 'icons)
(setq neo-window-width 40)
(setq neo-smart-open t)
(add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

(defun open-neotree ()
  (interactive)
  (evil-window-top)
  (neotree-projectile-action))

;; Relative linum, maybe remove this...
(use-package linum-relative)
(require 'linum-relative)
(linum-relative-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'org-mode-hook 'linum-mode)

;; Show git changes in the gutter/fringe
(use-package git-gutter)
(require 'git-gutter)
(use-package git-gutter-fringe)
(require 'git-gutter-fringe)
(global-git-gutter-mode)
(setq-default right-fringe-width 20)
(setq git-gutter-fr:side 'right-fringe)


(provide 'ide)
