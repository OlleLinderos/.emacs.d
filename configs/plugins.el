;; package archives
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa"        . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu"          . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org"          . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("marmalade"    . "http://marmalade-repo.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t
      use-package-always-defer t)


(setq evil-want-C-u-scroll t)
(use-package evil
  :demand
  :config (evil-mode 1))
(require 'evil)

(use-package evil-leader
  :demand
  :config (progn
            (setq evil-leader/in-all-states t)
            (global-evil-leader-mode)))
(require 'evil-leader)


(use-package magit)
(require 'magit)


(use-package which-key :demand)
(setq which-key-idle-delay 0)
(which-key-mode)


(use-package company)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-tooltip-align-annotations t)
(setq company-idle-delay t)
(setq company-tooltip-limit 20)
(setq company-begin-commands '(self-insert-command))


(use-package emmet-mode)
(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)


(use-package cider)
(require 'cider)
(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")
(setq cider-auto-select-error-buffer nil)
(set-variable 'cider-stacktrace-frames-background-color "#161616")
(add-hook 'cider-mode-hook
   '(lambda () (add-hook 'after-save-hook
    '(lambda ()
       (if (and (boundp 'cider-mode) cider-mode)
    (cider-load-buffer))))))


(use-package flycheck)
(require 'flycheck)


(use-package tide)
(require 'tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(setq company-tooltip-align-annotations t)
(setq tide-format-options '(:indentSize 2))
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)


(use-package ng2-mode)
(require 'ng2-mode)

(setq typescript-indent-level 2)
(setq javascript-indent-level 2)


(use-package web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(defun my-web-mode-hook ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (set (make-local-variable 'company-backends) '(company-web-html))
)
(add-hook 'web-mode-hook 'my-web-mode-hook)


(use-package js2-mode
  :ensure t)
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))


(use-package company-tern)
(require 'company-tern)

(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))


(use-package with-editor)
(require 'with-editor)


(use-package ranger)
(require 'ranger)


(use-package ag)
(require 'ag)


(use-package rainbow-delimiters)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


(use-package shell-pop)
(require 'shell-pop)


(use-package ivy)
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)


(use-package avy)
(require 'avy)
(avy-setup-default)


(use-package smart-mode-line)
(require 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'respectful)
(sml/setup)


(use-package neotree)
(require 'neotree)
(setq neo-window-width 30)
(setq neo-smart-open t)
(add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

(defun open-neotree ()
  (interactive)
  (evil-window-top)
  (neotree-projectile-action))


(use-package linum-relative)
(require 'linum-relative)
(linum-relative-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'org-mode-hook 'linum-mode)


(use-package better-defaults)
(require 'better-defaults)


(use-package kubernetes-evil
  :ensure t
  :after kubernetes)
(require 'kubernetes-evil)


(use-package git-gutter)
(require 'git-gutter)


(use-package git-gutter-fringe)
(require 'git-gutter-fringe)
(global-git-gutter-mode)
(setq-default right-fringe-width 20)
(setq git-gutter-fr:side 'right-fringe)


(use-package counsel)
(require 'counsel)


(use-package counsel-projectile)
(require 'counsel-projectile)


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


(use-package perspective)
(require 'perspective)
(persp-mode)
(use-package persp-projectile)
(require 'persp-projectile)


(use-package autopair)
(require 'autopair)
(autopair-global-mode)


(setq custom-safe-themes t)
(use-package nord-theme)
(require 'nord-theme)


(provide 'plugins)
