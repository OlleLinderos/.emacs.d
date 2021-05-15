;; (use-package python-mode
;;   :hook ((python-mode . (lambda ()
;;                           (when (require 'lsp-python nil t)
;;                             (lsp))))))

(use-package pyvenv
  :demand t
  :config
  (setq pyvenv-workon "emacs")  ; Default venv
  (pyvenv-tracking-mode 1))  ; Automatically use pyvenv-workon via dir-locals

(provide 'init-python)
