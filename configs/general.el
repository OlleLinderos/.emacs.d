(setq-default indent-tabs-mode nil
              truncate-lines t
              shell-file-name "/bin/zsh")

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(add-to-list 'exec-path "/usr/local/bin")

(defalias 'yes-or-no-p 'y-or-n-p)

(setq delete-old-versions -1
      version-control t
      vc-make-backup-files t
      backup-directory-alist `(("." . "~/.emacs.d/backups"))
      vc-follow-symlinks t
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))
      ring-bell-function 'ignore
      sentence-end-double-space nil
      default-fill-column 80
      mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil))
      mouse-wheel-progressive-speed nil
      mac-option-key-is-meta nil
      mac-option-modifier nil
      coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8)

(set-language-environment "UTF-8")
(add-hook 'prog-mode-hook 'column-number-mode)
(toggle-scroll-bar -1)
(menu-bar-mode -1)

(global-hl-line-mode)

(use-package with-editor)

(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

(use-package counsel)
(use-package counsel-projectile)

(use-package avy
  :config
  (avy-setup-default))

(use-package which-key :demand
  :init
  (setq which-key-idle-delay 0)
  (which-key-mode))

(use-package ranger)

(use-package better-defaults)

(provide 'general)
