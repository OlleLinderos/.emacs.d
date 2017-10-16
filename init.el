;;
;; Disable defaults
;;
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;;
;; Preferences
;;
(setq scroll-margin 10)
(setq tab-width 2
      indent-tabs-mode nil)

(setq-default truncate-lines t)
(setq-default indent-tabs-mode nil)

(when (member "Space Mono" (font-family-list))
  (set-face-attribute 'default nil :font "Space Mono" :height 140))

(set-background-color "black")
(set-foreground-color "white")
(set-face-attribute 'fringe nil :background nil)

;;
;; Greeting intead of *scratch*
;;
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'text-mode
      initial-scratch-message  "

      Hello my old friend")

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
  "l" 'perspective-map
  "p" 'projectile-command-map
  "w" 'evil-window-map)

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

;;
;; Initialize packages and hooks
;; 
(use-package which-key :demand)
(which-key-mode)
(smex-initialize)
(projectile-mode)
(autopair-global-mode)
(linum-relative-mode)
(persp-mode)

(add-hook 'prog-mode-hook 'column-number-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'org-mode-hook 'linum-mode)

(setq which-key-idle-delay 0)

;; Neo-tree 
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

(add-hook 'js2-mode-hook 'ac-js2-mode)

;;
;; Major modes
;;
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (emmet-mode)
  (global-set-key (kbd "TAB") 'emmet-expand-line)
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
 '(neo-theme (quote ascii))
 '(nil nil t)
 '(package-selected-packages
   (quote
    (web-mode js2-mode which-key use-package swoop sml-mode smex smart-mode-line powerline php-extras persp-projectile persp-mode-projectile-bridge nord-theme nlinum neotree linum-relative evil-leader emmet-mode company-tern better-defaults autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(swoop-face-header-format-line ((t (:foreground "#999999"))))
 '(swoop-face-line-buffer-name ((t (:background "#0099cc" :foreground "#111111")))))
