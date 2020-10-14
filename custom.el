(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-ghc-show-info t)
 '(company-quickhelp-color-background "#3E4452")
 '(company-quickhelp-color-foreground "#ABB2BF")
 '(custom-enabled-themes (quote (nord smart-mode-line-respectful)))
 '(global-git-gutter-mode t)
 '(js2-highlight-level 3)
 '(neo-theme (quote icons))
 '(package-selected-packages
   (quote
    (terraform-mode markdown-mode go-mode arduino-mode flymake-haskell-multi parinfer helm-robe multi-term ranger paredit evil-leader evil autopair projectile git-gutter-fringe git-gutter better-defaults linum-relative neotree smart-mode-line avy ivy shell-pop rainbow-delimiters ag golden-ratio with-editor company which-key use-package)))
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
 '(default ((t (:inherit nil :stipple nil :foreground "#D8DEE9" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :width normal :foundry "CF  " :family "Space Mono"))))
 '(css-selector ((t (:inherit font-lock-function-name-face))))
 '(fringe ((t (:foreground "#D8DEE9"))))
 '(highlight ((((class color) (min-colors 89)) (:foreground "#88C0D0" :background "#434C5E"))))
 '(hl-line ((t (:background "#2f3647"))))
 '(js2-object-property ((t (:foreground "LightSteelBlue2"))))
 '(linum ((t (:foreground "#4C566A"))))
 '(linum-relative-current-face ((t (:foreground "#eee"))))
 '(mode-line ((t (:background "#2c3242" :foreground "#88C0D0" :inverse-video nil))))
 '(mode-line-inactive ((t (:background "#222733" :foreground "#D8DEE9" :inverse-video nil))))
 '(neo-root-dir-face ((((class color) (min-colors 89)) (:foreground "#8FBCBB" :weight bold))))
 '(persp-selected-face ((t (:foreground "FF9900"))))
 '(sml/minor-modes ((t (:foreground "#778899" :width normal))))
 '(term ((t (:background "#181b23" :foreground "#D8DEE9"))))
 '(tide-hl-identifier-face ((t (:inherit highlight :foreground "#ff9900")))))
