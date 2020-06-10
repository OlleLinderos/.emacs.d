;; (use-package platformio-mode)

;; (add-to-list 'company-backends 'company-irony)

;; (add-hook 'c++-mode-hook (lambda ()
;;                            (irony-mode)
;;                            (irony-eldoc)
;;                            (platformio-conditionally-enable)))

;; (add-hook 'irony-mode-hook
;;           (lambda ()
;;             (define-key irony-mode-map [remap completion-at-point]
;;               'irony-completion-at-point-async)

;;             (define-key irony-mode-map [remap complete-symbol]
;;               'irony-completion-at-point-async)

;;             (irony-cdb-autosetup-compile-options)))
            
;; (add-hook 'flycheck-mode-hook 'flycheck-irony-setup)


(provide 'init-cpp)
