(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (smart-mode-line-respectful)))
 '(global-git-gutter-mode t)
 '(js2-highlight-level 3)
 '(neo-theme (quote icons) t)
 '(package-selected-packages
   (quote
    (multi-term ranger paredit evil-leader evil autopair projectile git-gutter-fringe git-gutter better-defaults linum-relative neotree smart-mode-line avy ivy shell-pop rainbow-delimiters ag golden-ratio with-editor company which-key use-package)))
 '(shell-pop-shell-type
   (quote
    ("ansi-term" "*ansi-term*"
     (lambda nil
       (ansi-term shell-pop-term-shell))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#232833" :foreground "#D8DEE9" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "Space Mono"))))
 '(css-selector ((t (:inherit font-lock-function-name-face))))
 '(fringe ((t (:background "#232833" :foreground "#D8DEE9"))))
 '(highlight ((((class color) (min-colors 89)) (:foreground "#88C0D0" :background "#434C5E"))))
 '(hl-line ((t (:background "#2f3647"))))
 '(js2-object-property ((t (:foreground "LightSteelBlue2"))))
 '(linum ((t (:background "#232833" :foreground "#4C566A"))))
 '(mode-line ((t (:background "#38414f" :foreground "#88C0D0" :inverse-video nil))))
 '(neo-root-dir-face ((((class color) (min-colors 89)) (:foreground "#8FBCBB" :weight bold))))
 '(persp-selected-face ((t (:foreground "FF9900"))))
 '(sml/minor-modes ((t (:foreground "#778899" :width normal))))
 '(tide-hl-identifier-face ((t (:inherit highlight :foreground "#ff9900")))))
