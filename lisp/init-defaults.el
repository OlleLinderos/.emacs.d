;; -*- lexical-binding: t; -*-

(setq-default indent-tabs-mode nil
              tab-width 4
              truncate-lines t
              fill-column 80
              explicit-shell-file-name "/bin/zsh"
              shell-file-name "zsh")

;; Backups / auto-saves out of the working tree, no lockfiles.
(make-directory (expand-file-name "backups" user-emacs-directory) t)
(make-directory (expand-file-name "auto-save" user-emacs-directory) t)
(setq delete-old-versions t          ; trim excess numbered backups silently
      version-control t
      vc-make-backup-files t
      backup-by-copying t
      backup-directory-alist `(("." . ,(expand-file-name "backups" user-emacs-directory)))
      auto-save-file-name-transforms `((".*" ,(expand-file-name "auto-save/" user-emacs-directory) t))
      create-lockfiles nil
      vc-follow-symlinks t
      ring-bell-function 'ignore
      sentence-end-double-space nil
      use-short-answers t)

(set-language-environment "UTF-8")

;; Smooth scrolling
(setq scroll-conservatively 101
      mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil))
      mouse-wheel-progressive-speed nil)
(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1))

;; Animations aren't cool enough
(setq pulse-flag nil)
(with-eval-after-load 'xref
  (remove-hook 'xref-after-jump-hook #'xref-pulse-momentarily)
  (remove-hook 'xref-after-return-hook #'xref-pulse-momentarily))

(column-number-mode 1)
(global-hl-line-mode 1)
(global-auto-revert-mode 1)
(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)

(add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))
(add-hook 'text-mode-hook (lambda () (setq show-trailing-whitespace t)))

;; I don't want multiple clipboard registers. Yanking and pasting should just use the regular
;; wayland clipboard.
(when (and (getenv "WAYLAND_DISPLAY") (executable-find "wl-copy"))
  (setq interprogram-cut-function
        (lambda (text)
          (let ((proc (make-process :name "wl-copy"
                                    :command '("wl-copy")
                                    :connection-type 'pipe
                                    :noquery t)))
            (process-send-string proc text)
            (process-send-eof proc))))
  (setq interprogram-paste-function
        (lambda ()
          (let ((text (with-temp-buffer
                        (when (eq 0 (call-process "timeout" nil t nil
                                                  "1" "wl-paste" "-n" "-t" "text"))
                          (buffer-string)))))
            (when (and text (not (string-empty-p text)))
              text)))))

(provide 'init-defaults)
