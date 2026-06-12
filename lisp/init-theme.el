;; -*- lexical-biding: t -*-

(setq custom-safe-themes t)

(setq initial-major-mode 'text-mode
      initial-scratch-message "




              Hello my old friend")

(when (member "JetBrainsMono Nerd Font" (font-family-list))
  (set-face-attribute 'default nil
                      :font (font-spec :family "JetBrainsMono Nerd Font" :size 16)))

(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'macchiato)
  (catppuccin-set-color 'red "#ee99a0")
  (catppuccin-set-color 'peach "#ef9f76")
  (catppuccin-set-color 'mauve "#ca9ee6")
  (load-theme 'catppuccin t))

(dolist (face '(font-lock-function-name-face font-lock-function-call-face))
  (when (facep face)
    (set-face-attribute face nil :foreground "#b7bdf8")))

(when (facep 'font-lock-type-face)
  (set-face-attribute 'font-lock-type-face nil :foreground "#f0c6c6"))

(dolist (face '(font-lock-property-name-face font-lock-property-use-face))
  (when (facep face)
    (set-face-attribute face nil :foreground "#b7bdf8")))

(provide 'init-theme)
