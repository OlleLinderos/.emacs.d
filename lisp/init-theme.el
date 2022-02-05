(when (member "Source Code Pro" (font-family-list))
  (set-face-attribute 'default nil :font "Source Code Pro" :height 165))

(setq custom-safe-themes t
      ns-use-proxy-icon nil
      frame-title-format nil
      inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'text-mode
      initial-scratch-message "




              Hello my old friend")

(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
        sml/theme 'respectful
        sml/name-width 60
        sml/mode-width 'full
        sml/shorten-modes t)
  (sml/setup))

(use-package all-the-icons)

(require 'atom-one-dark-theme)
(add-hook 'after-init-hook (lambda ()
                             (load-theme 'atom-one-dark t)))

(set-face-attribute 'fringe nil :background nil)

(provide 'init-theme)
