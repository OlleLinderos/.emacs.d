(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

;; (use-package lsp-python-ms
;;   :config
;;   (setq lsp-pyls-plugins-flake8-enabled t)
;;   (lsp-register-custom-settings
;;    '(("pyls.plugins.pyls_mypy.enabled" t t)
;;      ("pyls.plugins.pyls_mypy.live_mode" nil t)
;;      ("pyls.plugins.pyls_black.enabled" t t)
;;      ("pyls.plugins.pyls_isort.enabled" t t)

;;      ;; Disable these as they're duplicated by flake8
;;      ("pyls.plugins.pycodestyle.enabled" nil t)
;;      ("pyls.plugins.mccabe.enabled" nil t)
;;      ("pyls.plugins.pyflakes.enabled" nil t)))
;;   :init (setq lsp-python-ms-auto-install-server t)
;;   :hook (python-mode . (lambda ()
;;                          (flycheck-add-next-checker 'lsp '(warning . python-pylint))
;;                           (require 'lsp-python-ms)
;;                           (lsp))))

;; (use-package pyvenv
;;   :demand t
;;   :config
;;   (setq pyvenv-workon "emacs")
;;   (pyvenv-tracking-mode 1))

(provide 'init-python)
