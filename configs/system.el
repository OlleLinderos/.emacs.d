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

