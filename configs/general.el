;; Defaults
(setq-default indent-tabs-mode nil)
(setq-default truncate-lines t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) )
(setq vc-follow-symlinks t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
(setq ring-bell-function 'ignore)
(setq sentence-end-double-space nil)
(setq default-fill-column 80)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(setq mac-option-key-is-meta nil)
(setq mac-option-modifier nil)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(set-language-environment "UTF-8")
(add-hook 'prog-mode-hook 'column-number-mode)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(add-to-list 'exec-path "/usr/local/bin")
(setq-default shell-file-name "/bin/zsh")

(global-hl-line-mode)


;; Theming
(setq nord-comment-brightness 15)
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)
(set-face-attribute 'fringe nil :background nil)

(when (member "Space Mono" (font-family-list))
  (set-face-attribute 'default nil :font "Space Mono" :height 140))

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'text-mode
      initial-scratch-message "




              Hello my old friend")

(if (display-graphic-p)
    (progn
      (setq default-frame-alist
            '((top . 30)
              (left . 29)
              (alpha . (97 . 97))
              (ns-transparent-titlebar . t)
              (tool-bar-lines . 0)
              (width . 135)
              (height . 39)))))

(provide 'general)
