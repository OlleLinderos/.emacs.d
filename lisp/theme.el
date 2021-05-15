(when (member "Droid Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "Droid Sans Mono" :height 143))

(setq ns-use-proxy-icon nil
      frame-title-format nil
      inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'text-mode
      initial-scratch-message "




              Hello my old friend")

(if (display-graphic-p)
    (progn
      (setq default-frame-alist
            '((top . 30)
              (left . 29)
              (alpha . (100 . 100))
              (ns-transparent-titlebar . t)
              (tool-bar-lines . 0)
              (width . 135)
              (height . 39)))))

(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (sml/setup))

(use-package all-the-icons)

(setq custom-safe-themes t)

(require 'atom-one-dark-theme)
(add-hook 'after-init-hook (lambda ()
                             (load-theme 'atom-one-dark t)))

(set-face-attribute 'fringe nil :background nil)

(provide 'theme)