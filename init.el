;;
;; Preferences
;;
(setq frame-title-format "GNU Emacs: %b")
(set-language-environment "UTF-8")
(setq scroll-margin 10)
(setq tab-width 4
      indent-tabs-mode nil)

(setq-default truncate-lines t)
(setq-default indent-tabs-mode nil)

(when (member "Space Mono for Powerline" (font-family-list))
  (set-face-attribute 'default nil :font "Space Mono for Powerline" :height 140))

(set-background-color "black")
(set-foreground-color "white")
(set-face-attribute 'fringe nil :background nil)

;;
;; Greeting intead of *scratch*
;;
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'emacs-lisp-mode
      initial-scratch-message
";;
;;
;;      Hello my old friend
;;
;; 

")

;; Reize initial window
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 120) 
              (height . 32)
              ))

      (setq default-frame-alist
            '(
              (top . 40)
              (left . 20)
              (tool-bar-lines . 0)
              (width . 120)
              (height . 32)
              )))
  (progn
    (setq initial-frame-alist
          '(
            (tool-bar-lines . 0)))
    (setq default-frame-alist
          '(
            (tool-bar-lines . 0)))))

;;
;; Set basics
;;
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) )
(setq vc-follow-symlinks t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t) ))
(setq ring-bell-function 'ignore)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq sentence-end-double-space nil)
(setq default-fill-column 80)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;;
;; Mac keyboard
;;
(setq mac-option-key-is-meta nil)
(setq mac-option-modifier nil)

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
(use-package all-the-icons)
(require 'all-the-icons)

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

;; Multiple Cursors
(progn
  (define-prefix-command 'multiple-cursors-map)
  (define-key multiple-cursors-map (kbd "j") 'evil-mc-make-cursor-move-next-line)
  (define-key multiple-cursors-map (kbd "r") 'evil-mc-undo-all-cursors)
  (define-key multiple-cursors-map (kbd "h") 'evil-mc-make-cursor-at-pos)
  )

;; General file-map
(progn
  (define-prefix-command 'file-map)
  (define-key file-map (kbd "f") 'find-file)
  (define-key file-map (kbd "d") 'dired)
  )

;; Text actions map
(progn
  (define-prefix-command 'text-map)
  (define-key text-map (kbd "x") 'delete-trailing-whitespace)
  (define-key text-map (kbd "t") 'toggle-truncate-lines)
  )

(global-set-key (kbd "<C-tab>") 'evil-window-next)

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
;; Autocomplete
;; 
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay t)

;; Major modes
;;
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js2-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '((company-yasnippet)))))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (emmet-mode)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

(defun my-setup-indent (n)
  (setq c-basic-offset n)
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n) ; css-mode
  (setq web-mode-style-padding n)
  (setq web-mode-script-padding n)
  )
(my-setup-indent 4)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-theme (quote icons))
 '(nil nil t)
 '(package-selected-packages
   (quote
    (flycheck company-php yasnippet all-the-icons magit-popup magit git-gutter-fringe smart-tabs-mode evil-mc golden-ratio ag rainbow-delimiters php-mode company web-mode js2-mode which-key use-package swoop smex smart-mode-line php-extras nord-theme neotree linum-relative evil-leader emmet-mode company-tern better-defaults autopair)))
 '(sml/projectile-replacement-format "[%s] ")
 '(sml/theme (quote respectful)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(sml/git ((t (:inherit nil :foreground "#A4BA83" :weight bold))))
 '(sml/minor-modes ((t (:foreground "#A4BA83"))))
 '(swoop-face-header-format-line ((t (:foreground "#999999"))))
 '(swoop-face-line-buffer-name ((t (:background "#0099cc" :foreground "#111111")))))

(add-to-list 'load-path "~/.emacs.d/site-lisp/magit/lisp")
(require 'magit)

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/site-lisp/magit/Documentation/"))
