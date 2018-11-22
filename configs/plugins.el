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

;; Evil mode 
(setq evil-want-C-u-scroll t) ;; vim scrolling
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

;; magit
(use-package magit)
(require 'magit)

;; which-key
(use-package which-key :demand)
(setq which-key-idle-delay 0)
(which-key-mode)

;; company
(use-package company)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-tooltip-align-annotations t)
(setq company-idle-delay t)

;; CIDER
(use-package cider)
(require 'cider)
(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")
(add-hook 'cider-mode-hook
   ;; load to repl on save
   '(lambda () (add-hook 'after-save-hook
    '(lambda ()
       (if (and (boundp 'cider-mode) cider-mode)
    (cider-load-buffer))))))

;; with-editor
(use-package with-editor)
(require 'with-editor)

;; golden ratio
(use-package golden-ratio)
(require 'golden-ratio)

;; there is ranger for emacs?!
(use-package ranger)
(require 'ranger)

;; ag
(use-package ag)
(require 'ag)

;; rainbow delimiters
(use-package rainbow-delimiters)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; shell pop
(use-package shell-pop)
(require 'shell-pop)

;; ivy
(use-package ivy)
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; avy
(use-package avy)
(require 'avy)
(avy-setup-default)

;; smart-mode-line
(use-package smart-mode-line)
(require 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'respectful)
(sml/setup)

;; neotree
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

; linum-relative
(use-package linum-relative)
(require 'linum-relative)
(linum-relative-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'org-mode-hook 'linum-mode)

;; better-defaults
(use-package better-defaults)
(require 'better-defaults)

;; git-gutter
(use-package git-gutter)
(require 'git-gutter)

;; git-gutter-fringe
(use-package git-gutter-fringe)
(require 'git-gutter-fringe)
(global-git-gutter-mode)
(setq-default right-fringe-width 20)
(setq git-gutter-fr:side 'right-fringe)

;; counsel
(use-package counsel)
(require 'counsel)

;; counsel projectile
(use-package counsel-projectile)
(require 'counsel-projectile)

;; projectile
(use-package projectile)
(require 'projectile)
(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)
(projectile-mode)

;; autopair
(use-package autopair)
(require 'autopair)
(autopair-global-mode)

;; Nord theme :D
(setq custom-safe-themes t)
(use-package nord-theme)
(require 'nord-theme)
