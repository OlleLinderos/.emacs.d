;;
;; Plugin management
;;
(require 'package)
  (add-to-list 'package-archives '("melpa"     . "http://melpa.org/packages/"))
  (add-to-list 'package-archives '("gnu"       . "http://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives '("org"       . "http://orgmode.org/elpa/"))
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t
      use-package-always-defer t)

(use-package which-key :demand)
(use-package yasnippet)
(require 'yasnippet)
(use-package company)
(require 'company)
(use-package evil-mc)
(require 'evil-mc)
(use-package with-editor)
(require 'with-editor)
(use-package golden-ratio)
(require 'golden-ratio)
(use-package ag)
(require 'ag)
(use-package rainbow-delimiters)
(require 'rainbow-delimiters)
(use-package php-mode)
(require 'php-mode)
(use-package web-mode)
(require 'web-mode)
(use-package js2-mode)
(require 'js2-mode)
(use-package which-key)
(require 'which-key)
(use-package swoop)
(require 'swoop)
(use-package smex)
(require 'smex)
(use-package smart-mode-line)
(require 'smart-mode-line)
(use-package php-extras)
(require 'php-extras)
(use-package nord-theme)
(require 'nord-theme)
(use-package neotree)
(require 'neotree)
(use-package linum-relative)
(require 'linum-relative)
(use-package emmet-mode)
(require 'emmet-mode)
;; (require 'company-tern)
(use-package better-defaults)
(require 'better-defaults)
(use-package smart-tabs-mode)
(require 'smart-tabs-mode)
(use-package git-gutter)
(require 'git-gutter)
(use-package git-gutter-fringe)
(require 'git-gutter-fringe)
(use-package which-key :demand)
(require 'which-key)
(use-package projectile)
(require 'projectile)
(use-package autopair)
(require 'autopair)
(use-package persp-mode)
(require 'persp-mode)

(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)

;; 
;; Evil mode 
;; 
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

(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))

(evil-leader/set-leader "SPC")
(evil-leader/set-key
  "SPC" 'smex
  "TAB" 'neotree-toggle
  "/" 'comment-region
  "\\\\" 'uncomment-region
  "b" 'buffer-menu
  "d" 'text-map
  "f" 'file-map
  "s" 'swoop
  "g" 'magit-status
  "m" 'multiple-cursors-map
  "l" 'perspective-map
  "p" 'projectile-command-map
  "w" 'evil-window-map)


;;
;; Initialize packages and hooks
;; 
(which-key-mode)
(smex-initialize)
;; (projectile-global-mode)
(autopair-global-mode)
(linum-relative-mode)
(persp-mode)
(global-evil-mc-mode 1)
(global-git-gutter-mode)
(yas-global-mode)

(add-hook 'prog-mode-hook 'column-number-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'org-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(setq which-key-idle-delay 0)

(setq-default right-fringe-width 20)
(setq git-gutter-fr:side 'right-fringe)

;; Rainbow delimiters
(set-face-foreground 'rainbow-delimiters-depth-1-face "white")
(set-face-foreground 'rainbow-delimiters-depth-2-face "cyan")
(set-face-foreground 'rainbow-delimiters-depth-3-face "yellow")
(set-face-foreground 'rainbow-delimiters-depth-4-face "green")
(set-face-foreground 'rainbow-delimiters-depth-5-face "orange")
(set-face-foreground 'rainbow-delimiters-depth-6-face "purple")
(set-face-foreground 'rainbow-delimiters-depth-7-face "white")
(set-face-foreground 'rainbow-delimiters-depth-8-face "cyan")
(set-face-foreground 'rainbow-delimiters-depth-9-face "yellow")
(set-face-foreground 'rainbow-delimiters-unmatched-face "red")

;; Neo-tree 
(setq neo-window-width 30)
(setq neo-smart-open t)
(add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

;;
;; Theming
;; 
(setq nord-comment-brightness 15)
(load-theme 'nord t)

(setq sml/no-confirm-load-theme t)
(setq sml/theme 'respectful)
(sml/setup)


;;
;; Initialize packages and hooks
;; 
(which-key-mode)
(smex-initialize)
;; (projectile-global-mode)
(autopair-global-mode)
(linum-relative-mode)
(persp-mode)
(global-evil-mc-mode 1)
(global-git-gutter-mode)
(yas-global-mode)

(add-hook 'prog-mode-hook 'column-number-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'org-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(setq which-key-idle-delay 0)

(setq-default right-fringe-width 20)
(setq git-gutter-fr:side 'right-fringe)

;; Rainbow delimiters
(set-face-foreground 'rainbow-delimiters-depth-1-face "white")
(set-face-foreground 'rainbow-delimiters-depth-2-face "cyan")
(set-face-foreground 'rainbow-delimiters-depth-3-face "yellow")
(set-face-foreground 'rainbow-delimiters-depth-4-face "green")
(set-face-foreground 'rainbow-delimiters-depth-5-face "orange")
(set-face-foreground 'rainbow-delimiters-depth-6-face "purple")
(set-face-foreground 'rainbow-delimiters-depth-7-face "white")
(set-face-foreground 'rainbow-delimiters-depth-8-face "cyan")
(set-face-foreground 'rainbow-delimiters-depth-9-face "yellow")
(set-face-foreground 'rainbow-delimiters-unmatched-face "red")

;; Neo-tree 
(setq neo-window-width 30)
(setq neo-smart-open t)
(add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

;;
;; Theming
;; 
(setq nord-comment-brightness 15)
(load-theme 'nord t)

(setq sml/no-confirm-load-theme t)
(setq sml/theme 'respectful)
(sml/setup)

(add-to-list 'load-path "~/.emacs.d/site-lisp/magit/lisp")
(require 'magit)

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/site-lisp/magit/Documentation/"))

