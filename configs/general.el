;;
;; General
;;
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

;;
;; General Tools
;;
(use-package with-editor)
(require 'with-editor)

;; Ivy... Remove?
(use-package ivy)
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; Counsel support for Projectile
(use-package counsel-projectile)
(require 'counsel-projectile)

;; It's just counsel
(use-package counsel)
(require 'counsel)

;; Jump around
(use-package avy)
(require 'avy)
(avy-setup-default)

;; Show commands
(use-package which-key :demand)
(setq which-key-idle-delay 0)
(which-key-mode)

;; Ranger file explorer
(use-package ranger)
(require 'ranger)

;; Easy terminal access
(use-package shell-pop)
(require 'shell-pop)

;; Better defaults (?)
(use-package better-defaults)
(require 'better-defaults)


(provide 'general)
