;; (with-eval-after-load 'lsp-mode
;;   (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\].yarn")
;;   (setq lsp-log-io nil)
;;   (setq lsp-enable-snippet nil)
;; ;;  (setq lsp-enable-completion-at-point nil)
;; ;;  (setq lsp-enable-symbol-highlighting nil)
;;   ;; (setq lsp-restart 'auto-restart)

;;   (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\)$" lsp-file-watch-ignored) ; json

;;   ;; don't ping LSP lanaguage server too frequently
;;   ;; (defvar lsp-on-touch-time 0)
;;   ;; (defadvice lsp-on-change (around lsp-on-change-hack activate)
;;   ;;   ;; don't run `lsp-on-change' too frequently
;;   ;;   (when (> (- (float-time (current-time))
;;   ;;               lsp-on-touch-time) 30) ;; 30 seconds
;;   ;;     (setq lsp-on-touch-time (float-time (current-time)))
;;   ;;     ad-do-it))

;;   )

(use-package lsp-mode
  :init
  (setq lsp-prefer-capf t
        lsp-log-io nil)
  :config
  (setq lsp-idle-delay 0.2
        lsp-log-io nil
        lsp-enable-symbol-highlighting t
        lsp-enable-snippet nil)
  (defun amk-lsp-format-on-save ()
    (add-hook 'before-save-hook #'amk-lsp-format-buffer-quick nil t))
  (defun amk-lsp-disable-format-on-save ()
    (remove-hook 'before-save-hook #'amk-lsp-format-buffer-quick t))
  (defun amk-lsp-organize-imports-on-save ()
    (add-hook 'before-save-hook #'lsp-organize-imports nil t))
  :custom
  (lsp-solargraph-multi-root nil)
  :hook
  ((lsp-mode . lsp-enable-which-key-integration)))

(use-package lsp-ui
  :config
  (setq lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-delay 0.2
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-ignore-duplicates t
        lsp-ui-sideline-show-symbol nil
        
        lsp-ui-doc-delay 1
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-doc-show-with-mouse nil
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-alignment 'window
        lsp-ui-doc-header nil
        lsp-ui-doc-include-signature t
        lsp-ui-doc-use-childframe t
        
        lsp-ui-peek-fontify 'always)
  :commands lsp-ui-mode)

(use-package dap-mode)

(evil-leader/set-key "l" 'my-lsp-map)
(progn
  (define-prefix-command 'my-lsp-map)
  (define-key my-lsp-map (kbd ".") 'lsp-workspace-restart)
  (define-key my-lsp-map (kbd "a") 'lsp-execute-code-action)
  (define-key my-lsp-map (kbd "m") 'lsp-ui-imenu)
  (define-key my-lsp-map (kbd "d") 'lsp-ui-peek-find-definitions)
  (define-key my-lsp-map (kbd "i") 'lsp-ui-peek-find-implementation)
  (define-key my-lsp-map (kbd "r") 'lsp-ui-peek-find-references)
  (define-key my-lsp-map (kbd "s") 'lsp-ui-doc-show))

(provide 'init-lsp)
