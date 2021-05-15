(use-package platformio-mode)

(use-package arduino-mode
  :config
  (add-hook 'arduino-mode-hook 'c++-mode)
  (add-hook 'arduino-mode-hook 'platformio-mode)
  (add-hook 'arduino-mode-hook 'flycheck-mode)
  (add-hook 'arduino-mode-hook 'turn-on-eldoc-mode))

(use-package company-arduino
  :config
  (setq company-arduino-home "~/Arduino")
  (add-hook 'c++-mode-hook 'company-arduino-turn-on))

(provide 'init-platformio)
