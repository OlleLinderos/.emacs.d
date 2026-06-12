;;; -*- lexical-binding: t; -*-

(use-package cue-mode
  :mode "\\.cue\\'")

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(cue-mode . "cue"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("cue" "lsp"))
    :activation-fn (lsp-activate-on "cue")
    :priority -1
    :server-id 'cue-lsp)))

(add-hook 'cue-mode-hook
          (lambda ()
            (when (executable-find "cue")
              (lsp-deferred))))

(provide 'init-cue)
