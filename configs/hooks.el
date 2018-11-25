;; Scroll margin in really annoying in terminals and repl
(add-hook 'term-mode-hook
          (lambda ()
              (set (make-local-variable 'scroll-margin) 0)))

(add-hook 'cider-repl-mode-hook
          (lambda ()
              (set (make-local-variable 'scroll-margin) 0)))

(add-hook 'cider-stacktrace-mode-hook
          (lambda ()
              (set (make-local-variable 'scroll-margin) 0)))

(add-hook 'custom-mode-hook
           (lambda ()
               (set (make-local-variable 'scroll-margin) 0)))

 (add-hook 'messages-buffer-mode-hook
           (lambda ()
               (set (make-local-variable 'scroll-margin) 0)))


;; could be nice
;; (defun highlight-selected-window ()
;;   "Highlight selected window with a different background color."
;;   (walk-windows (lambda (w)
;;                   (unless (eq w (selected-window))
;;                     (with-current-buffer (window-buffer w)
;;                       (buffer-face-set '(:background "#3e4757"))))))
;;   (buffer-face-set 'default))
;; (add-hook 'buffer-list-update-hook 'highlight-selected-window)

