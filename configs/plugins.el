;; package archives
(require 'package)
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa"        . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu"          . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org"          . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("marmalade"    . "http://marmalade-repo.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t
      use-package-always-defer t)

;; which-key
(use-package which-key :demand)
(setq which-key-idle-delay 0)
(which-key-mode)

;; yasnippet
(use-package yasnippet)
(require 'yasnippet)
(yas-global-mode)

;; company
(use-package company)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay t)

;; evil multiple cursors
(use-package evil-mc)
(require 'evil-mc)
(global-evil-mc-mode 1)

;; with-editor
(use-package with-editor)
(require 'with-editor)

;; golden ratio
(use-package golden-ratio)
(require 'golden-ratio)

;; ag
(use-package ag)
(require 'ag)

;; rainbow delimiters
(use-package rainbow-delimiters)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(set-face-foreground 'rainbow-delimiters-depth-1-face "white")
(set-face-foreground 'rainbow-delimiters-depth-2-face "orange")
(set-face-foreground 'rainbow-delimiters-depth-3-face "yellow")
(set-face-foreground 'rainbow-delimiters-depth-4-face "green")
(set-face-foreground 'rainbow-delimiters-depth-5-face "cyan")
(set-face-foreground 'rainbow-delimiters-depth-6-face "purple")
(set-face-foreground 'rainbow-delimiters-depth-7-face "white")
(set-face-foreground 'rainbow-delimiters-depth-8-face "cyan")
(set-face-foreground 'rainbow-delimiters-depth-9-face "yellow")
(set-face-foreground 'rainbow-delimiters-unmatched-face "red")

;; php-mode
(use-package php-mode)
(require 'php-mode)

;; php-extras
(use-package php-extras)
(require 'php-extras)

;; rjsx-mode
(use-package rjsx-mode)
(require 'rjsx-mode)

;; web-mode
(use-package web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (emmet-mode)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; js2-mode
(use-package js2-mode)
(require 'js2-mode)
(add-hook 'js2-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '((company-yasnippet)))))

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

;; nord-theme
(use-package nord-theme)
(require 'nord-theme)
(setq nord-comment-brightness 15)
(load-theme 'nord t)

;; what on earth is this name
;; (use-package apropospriate-theme
;;   :ensure t
;;   :config 
;;    (load-theme 'apropospriate-dark t))

;; all-the-icons
(use-package all-the-icons)
(require 'all-the-icons)

;; neotree
(use-package neotree)
(require 'neotree)
(setq neo-window-width 30)
(setq neo-smart-open t)
(add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

;; linum-relative
(use-package linum-relative)
(require 'linum-relative)
(linum-relative-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'org-mode-hook 'linum-mode)

;; emmet
(use-package emmet-mode)
(require 'emmet-mode)

;; (require 'company-tern)

;; better-defaults
(use-package better-defaults)
(require 'better-defaults)

;; smart-tabs-mode
(use-package smart-tabs-mode)
(require 'smart-tabs-mode)

;; git-gutter
(use-package git-gutter)
(require 'git-gutter)

;; git-gutter-fringe
(use-package git-gutter-fringe)
(require 'git-gutter-fringe)
(global-git-gutter-mode)
(setq-default right-fringe-width 20)
(setq git-gutter-fr:side 'right-fringe)

;; projectile
(use-package projectile)
(require 'projectile)
(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)

;; autopair
(use-package autopair)
(require 'autopair)
(autopair-global-mode)

;; persp-mode
(use-package persp-mode)
(require 'persp-mode)
(persp-mode)

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

(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))

(evil-leader/set-leader "SPC")
(evil-leader/set-key
  "SPC" 'counsel-M-x
  "'" 'shell-pop
  "TAB" 'neotree-projectile-action
  "/" 'comment-region
  "\\\\" 'uncomment-region
  "b" 'buffer-menu
  "d" 'text-map
  "f" 'file-map
  "s" 'swiper
  "j" 'avy-map
  "t" 'toggle-map
  "g" 'magit-status
  "m" 'multiple-cursors-map
  "l" 'perspective-map
  "p" 'project-map
  "w" 'evil-window-map)

;; magit
(add-to-list 'load-path "~/.emacs.d/site-lisp/magit/lisp")
(require 'magit)

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/site-lisp/magit/Documentation/"))
