(setq-default indent-tabs-mode nil
              truncate-lines t
              explicit-shell-file-name "/bin/zsh"
              shell-file-name "zsh")

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(add-to-list 'exec-path "/usr/local/bin")

(when (memq window-system '(mac ns x))
 (use-package exec-path-from-shell
 :init
 (exec-path-from-shell-initialize)))

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

(require 'iso-transl)

(use-package with-editor)

(use-package ivy
  :config
  (define-key ivy-minibuffer-map (kbd "C-q") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-w") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-e") 'ivy-call)
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

(use-package counsel
  :config
  (setcdr (assoc 'counsel-M-x ivy-initial-inputs-alist) ""))

(use-package counsel-projectile)

(use-package avy
  :config
  (avy-setup-default))

(use-package which-key :demand
  :init
  (setq which-key-idle-delay 0.25)
  (which-key-mode))

(use-package better-defaults)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(provide 'general)
