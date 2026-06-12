;;  -*- lexical-binding: t; -*-

;; add formatting or no?
(defun boat/lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(when (and (treesit-available-p) (treesit-language-available-p 'go))
  (add-to-list 'major-mode-remap-alist '(go-mode . go-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
  (when (treesit-language-available-p 'gomod)
    (add-to-list 'auto-mode-alist '("/go\\.mod\\'" . go-mod-ts-mode)))
  (add-hook 'go-ts-mode-hook #'lsp-deferred)
  (add-hook 'go-ts-mode-hook #'boat/lsp-go-install-save-hooks))

(dolist (dir '("/usr/local/bin" "~/go/bin" "~/.local/bin"))
  (let ((expanded (expand-file-name dir)))
    (when (file-directory-p expanded)
      (add-to-list 'exec-path expanded)
      (unless (string-match-p (regexp-quote expanded) (or (getenv "PATH") ""))
        (setenv "PATH" (concat (getenv "PATH") ":" expanded))))))
(setenv "GOPROXY" "https://proxy.golang.org,direct")

(provide 'init-go)
