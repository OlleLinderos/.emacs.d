(setq-default indent-tabs-mode nil
              truncate-lines t
              explicit-shell-file-name "/bin/zsh"
              shell-file-name "zsh")

(setq delete-old-versions -1
      version-control t
      vc-make-backup-files t
      backup-directory-alist `(("." . "~/.emacs.d/backups"))
      vc-follow-symlinks t
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))
      backup-by-copying t
      create-lockfiles nil
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
(tool-bar-mode -1)
(global-hl-line-mode)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setenv "GOPROXY" "https://proxy.golang.org,direct")
(add-to-list 'exec-path "/usr/local/bin")

(defalias 'yes-or-no-p 'y-or-n-p)

;;(when (memq window-system '(mac ns x))
;; (use-package exec-path-from-shell
;; :config
;; (exec-path-from-shell-initialize)))

;; Fixes <dead_tilde> type errors. 
;; (require 'iso-transl)

(use-package with-editor) ;; Reliable emacsclient
(use-package better-defaults)

(provide 'init-defaults)
