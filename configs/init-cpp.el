(use-package irony-eldoc)
(use-package irony-mode) 
(use-package platformio-mode)

(add-to-list 'auto-mode-alist '("\\.ino$" . arduino-mode)) 

(add-hook 'c++-mode-hook (lambda ()
                           (irony-mode)
                           (irony-eldoc)
                           (platformio-conditionally-enable)))

(add-hook 'irony-mode-hook
          (lambda ()
            (define-key irony-mode-map [remap completion-at-point]
              'irony-completion-at-point-async)

            (define-key irony-mode-map [remap complete-symbol]
              'irony-completion-at-point-async)

            (irony-cdb-autosetup-compile-options)))

(provide 'init-cpp)
