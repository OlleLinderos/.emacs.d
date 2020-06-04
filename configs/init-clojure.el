(use-package cider
  :pin melpa-stable
  :config
  (add-hook 'cider-mode-hook
            '(lambda () (add-hook 'after-save-hook
                                  '(lambda ()
                                     (if (and (boundp 'cider-mode) cider-mode)
                                         (cider-load-buffer)))))))
(use-package clj-refactor)

(progn
  (define-prefix-command 'cider-map)
  (define-key cider-map (kbd "e") 'cider-eval-defun-at-point)
  (define-key cider-map (kbd "j") 'jackin-map))

(progn
  (define-prefix-command 'jackin-map)
  (define-key jackin-map (kbd "s") 'cider-jack-in-clojurescript)
  (define-key jackin-map (kbd "c") 'cider-jack-in-clojure))

(provide 'init-clojure)
