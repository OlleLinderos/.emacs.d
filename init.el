;; This is my Emacs configuration. There are many like it, but this one is mine.

(load "~/.emacs.d/configs/system.el")
(load "~/.emacs.d/configs/plugins.el")
(load "~/.emacs.d/configs/hotkeys.el")
(load "~/.emacs.d/configs/preferences.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(neo-theme (quote asci))
 '(package-selected-packages
   (quote
    (yasnippet magit-popup magit git-gutter-fringe smart-tabs-mode evil-mc golden-ratio ag rainbow-delimiters php-mode company web-mode js2-mode which-key use-package swoop smex smart-mode-line php-extras nord-theme neotree linum-relative evil-leader emmet-mode company-tern better-defaults autopair)))
 '(sml/projectile-replacement-format "[%s] ")
 '(sml/theme (quote respectful)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(sml/git ((t (:inherit nil :foreground "#A4BA83" :weight bold))))
 '(sml/minor-modes ((t (:foreground "#A4BA83"))))
 '(swoop-face-header-format-line ((t (:foreground "#999999"))))
 '(swoop-face-line-buffer-name ((t (:background "#0099cc" :foreground "#111111")))))
