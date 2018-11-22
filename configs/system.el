;; Setup
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)
(setq ns-use-proxy-icon nil)
(set-language-environment "UTF-8")
(windmove-default-keybindings)

(setq scroll-margin 10)

(add-hook 'term-mode-hook
          (lambda ()
              (set (make-local-variable 'scroll-margin) 0)))

(add-hook 'cider-repl-mode-hook
          (lambda ()
              (set (make-local-variable 'scroll-margin) 0)))

(add-hook 'custom-mode-hook
          (lambda ()
              (set (make-local-variable 'scroll-margin) 0)))

(add-hook 'messages-buffer-mode-hook
          (lambda ()
              (set (make-local-variable 'scroll-margin) 0)))

(setq-default truncate-lines t)

;; Mac keyboard
(setq mac-option-key-is-meta nil)
(setq mac-option-modifier nil)

;; Font
(when (member "Space Mono" (font-family-list))
  (set-face-attribute 'default nil :font "Space Mono" :height 140))

;; Fringe background
(set-face-attribute 'fringe nil :background nil)

;; opacity
(set-frame-parameter (selected-frame) 'alpha '(99 . 99))
(add-to-list 'default-frame-alist '(alpha . (99 . 99)))

;; comment brightness
(setq nord-comment-brightness 15)

;; default shell
(setq-default shell-file-name "/bin/zsh")

;; Greeting
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'text-mode
      initial-scratch-message "




              Hello my old friend")

;; Reize initial window
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '((tool-bar-lines . 0)
              (width . 135) 
              (height . 39)))

      (setq default-frame-alist
            '((top . 30)
              (left . 29)
              (ns-transparent-titlebar . t)
              (tool-bar-lines . 0)
              (width . 135)
              (height . 39))))
  (progn
    (setq initial-frame-alist
          '(
            (tool-bar-lines . 0)))
    (setq default-frame-alist
          '(
            (tool-bar-lines . 0)))))

;; Set basics
(add-hook 'prog-mode-hook 'column-number-mode)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq-default indent-tabs-mode nil)
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

(add-to-list 'exec-path "/usr/local/bin")
