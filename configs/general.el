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
(toggle-scroll-bar -1)
(add-hook 'prog-mode-hook 'column-number-mode)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(add-to-list 'exec-path "/usr/local/bin")
(setq-default shell-file-name "/bin/zsh")

(global-hl-line-mode)

(use-package with-editor)

(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

(use-package counsel-projectile)

(use-package counsel)

(use-package avy)
(avy-setup-default)

(use-package which-key :demand
  :init
  (setq which-key-idle-delay 0)
  (which-key-mode))

(use-package ranger)

(use-package shell-pop)

(use-package better-defaults)

(provide 'general)
