;; This is my Emacs configuration. There are many like it, but this one is mine.


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "~/.emacs.d/configs/system.el")
(load "~/.emacs.d/configs/plugins.el")
(load "~/.emacs.d/configs/hotkeys.el")
(load "~/.emacs.d/configs/preferences.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (flatland-black)))
 '(custom-safe-themes
   (quote
    ("748d0e2ffdaf95015a539dcc95ab888283284ad7b076963760422cbe5e21903a" "3448e3f5d01b39ce75962328a5310438e4a19e76e4b691c21c8e04ca318a5f62" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "4154caa8409ff2eb6f74c913741420e7103b9ea26c3c7d1a5a16592d0d2f43e0" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "c158c2a9f1c5fcf27598d313eec9f9dceadf131ccd10abc6448004b14984767c" "7527f3308a83721f9b6d50a36698baaedc79ded9f6d5bd4e9a28a22ab13b3cb1" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "c4bd8fa17f1f1fc088a1153ca676b1e6abc55005e72809ad3aeffb74bd121d23" "70f5a47eb08fe7a4ccb88e2550d377ce085fedce81cf30c56e3077f95a2909f2" "5a0eee1070a4fc64268f008a4c7abfda32d912118e080e18c3c865ef864d1bea" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(frame-background-mode (quote dark))
 '(fringe-mode 20 nil (fringe))
 '(neo-theme (quote ascii))
 '(package-selected-packages
   (quote
    (ghub vue-mode vue-html-mode melancholy-theme liso-theme ng2-mode flatland-black-theme perspective angular-mode tide ivy dumb-jump shell-pop avy exec-path-from-shell counsel-projectile counsel yasnippet magit-popup magit git-gutter-fringe smart-tabs-mode evil-mc golden-ratio ag rainbow-delimiters php-mode company web-mode js2-mode which-key use-package smart-mode-line php-extras nord-theme neotree linum-relative evil-leader emmet-mode company-tern better-defaults autopair)))
 '(shell-pop-shell-type
   (quote
    ("ansi-term" "*ansi-term*"
     (lambda nil
       (ansi-term shell-pop-term-shell)))))
 '(shell-pop-window-size 30)
 '(sml/no-confirm-load-theme nil)
 '(sml/projectile-replacement-format "[%s] ")
 '(sml/theme (quote respectful)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2E3440" :foreground "#ffffff" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 68 :width normal :foundry "ADBO" :family "Source Code Pro"))))
 '(ivy-current-match ((t (:background "#14b414" :foreground "FFF"))))
 '(linum-relative-current-face ((t (:inherit linum :background "#2E3440" :foreground "#FFF" :weight bold))))
 '(sml/git ((t (:inherit nil :foreground "#A4BA83" :weight bold))))
 '(sml/minor-modes ((t (:foreground "#A4BA83"))))
 '(swoop-face-header-format-line ((t (:foreground "#999999"))))
 '(swoop-face-line-buffer-name ((t (:background "#0099cc" :foreground "#111111"))))
 '(web-mode-html-tag-custom-face ((t (:inherit default))))
 '(web-mode-html-tag-face ((t (:foreground "white")))))
