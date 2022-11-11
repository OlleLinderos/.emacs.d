(use-package cider
  :pin melpa-stable
  :config
  (add-hook 'cider-mode-hook
            '(lambda () (add-hook 'after-save-hook
                                  '(lambda ()
                                     (if (and (boundp 'cider-mode) cider-mode)
                                         (cider-load-buffer)))))))

(use-package clj-refactor)

(evil-leader/set-key "c" 'cider-map)
(progn
    (define-prefix-command 'cider-map)
    (define-key cider-map (kbd "e") 'cider-eval-defun-at-point)
    (define-key cider-map (kbd "f") 'cider-find-dwim)
    (define-key cider-map (kbd "j") 'jackin-map)
    (define-key cider-map (kbd "r") 'cider-switch-to-repl-buffer)
    (define-key cider-map (kbd "s") 'cider-scratch))

  (progn
    (define-prefix-command 'jackin-map)
    (define-key jackin-map (kbd "s") 'cider-jack-in-clojurescript)
    (define-key jackin-map (kbd "c") 'cider-jack-in-clojure))

(use-package clojure-mode
  :hook ((clojure-mode . lsp-deferred)))

(provide 'init-clojure)
