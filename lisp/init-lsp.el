;;; -*- lexical-binding: t; -*-

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-idle-delay 0.2
        lsp-log-io nil
        ;; Hand completion to capf so corfu drives the popup (no company).
        lsp-completion-provider :none
        lsp-enable-snippet nil
        lsp-enable-symbol-highlighting t
        lsp-eldoc-render-all t
        ;; No breadcrumb header-line, no LSP segments in the mode-line.
        lsp-headerline-breadcrumb-enable nil
        lsp-modeline-diagnostics-enable nil
        lsp-modeline-workspace-status-enable nil
        lsp-modeline-code-actions-enable nil)
  :hook (lsp-mode . lsp-enable-which-key-integration))

(defun mine/lsp-ui-peek-expand-all (files)
  "Return all FILES so the lsp-ui-peek list opens fully expanded."
  (mapcar #'car files))

(use-package lsp-ui
  :after lsp-mode
  :init
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

        lsp-ui-peek-fontify 'always
        lsp-ui-peek-expand-function #'mine/lsp-ui-peek-expand-all))

(with-eval-after-load 'lsp-ui-doc
  (defun mine/lsp-ui-doc-strip-line-pad (&rest _)
    (let ((buf (get-buffer (lsp-ui-doc--make-buffer-name))))
      (when buf
        (with-current-buffer buf
          (setq-local line-prefix nil
                      wrap-prefix nil)))))
  (advice-add 'lsp-ui-doc--render-buffer
              :after #'mine/lsp-ui-doc-strip-line-pad))

;; g r / g i on any symbol, with peek preview
(defun mine/find-references-dwim ()
  (interactive)
  (if (and (bound-and-true-p lsp-mode) (require 'lsp-ui-peek nil t))
      (lsp-ui-peek-find-references)
    (call-interactively #'xref-find-references)))

(defun mine/find-implementation-dwim ()
  (interactive)
  (if (and (bound-and-true-p lsp-mode) (require 'lsp-ui-peek nil t))
      (condition-case nil
          (lsp-ui-peek-find-implementation)
        (user-error (lsp-ui-peek-find-definitions)))
    (call-interactively #'xref-find-definitions)))

(evil-define-key 'normal 'global (kbd "gr") 'mine/find-references-dwim)
(with-eval-after-load 'lsp-mode
  (evil-define-key 'normal lsp-mode-map (kbd "gi") 'mine/find-implementation-dwim))

(define-key mine/leader-map (kbd "d") 'lsp-ui-doc-glance)

(define-prefix-command 'my-lsp-map)
(define-key mine/leader-map (kbd "l") 'my-lsp-map)
(define-key my-lsp-map (kbd ".") 'lsp-workspace-restart)
(define-key my-lsp-map (kbd "a") 'lsp-execute-code-action)
(define-key my-lsp-map (kbd "m") 'lsp-ui-imenu)
(define-key my-lsp-map (kbd "d") 'lsp-ui-peek-find-definitions)
(define-key my-lsp-map (kbd "i") 'lsp-ui-peek-find-implementation)
(define-key my-lsp-map (kbd "r") 'lsp-ui-peek-find-references)
(define-key my-lsp-map (kbd "n") 'lsp-rename)
(define-key my-lsp-map (kbd "f") 'lsp-format-buffer)
(define-key my-lsp-map (kbd "s") 'lsp-ui-doc-show)

(setq lsp-tailwindcss-add-on-mode t)

(provide 'init-lsp)
