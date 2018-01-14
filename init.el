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
    ("c4bd8fa17f1f1fc088a1153ca676b1e6abc55005e72809ad3aeffb74bd121d23" "70f5a47eb08fe7a4ccb88e2550d377ce085fedce81cf30c56e3077f95a2909f2" "5a0eee1070a4fc64268f008a4c7abfda32d912118e080e18c3c865ef864d1bea" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(elscreen-tab-display-control nil)
 '(neo-theme (quote icons))
 '(package-selected-packages
   (quote
    (angular-snippets elscreen perspective angular-mode tide ivy dumb-jump shell-pop avy exec-path-from-shell counsel-projectile counsel yasnippet magit-popup magit git-gutter-fringe smart-tabs-mode evil-mc golden-ratio ag rainbow-delimiters php-mode company web-mode js2-mode which-key use-package smart-mode-line php-extras nord-theme neotree linum-relative evil-leader emmet-mode company-tern better-defaults autopair)))
 '(shell-pop-shell-type
   (quote
    ("ansi-term" "*ansi-term*"
     (lambda nil
       (ansi-term shell-pop-term-shell)))))
 '(shell-pop-window-size 30)
 '(sml/projectile-replacement-format "[%s] ")
 '(sml/theme (quote respectful)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elscreen-tab-background-face ((t nil)))
 '(elscreen-tab-current-screen-face ((t (:foreground "alternateSelectedControlTextColor"))))
 '(elscreen-tab-other-screen-face ((t (:foreground "windowFrameColor"))))
 '(neo-banner-face ((((class color) (min-colors 89)) (:foreground "#5E81AC"))))
 '(sml/git ((t (:inherit nil :foreground "#A4BA83" :weight bold))))
 '(sml/minor-modes ((t (:foreground "#A4BA83"))))
 '(swoop-face-header-format-line ((t (:foreground "#999999"))))
 '(swoop-face-line-buffer-name ((t (:background "#0099cc" :foreground "#111111")))))
