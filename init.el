;; This is my Emacs configuration. There are many like it, but this one is mine.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "~/.emacs.d/configs/system.el")
(load "~/.emacs.d/configs/plugins.el")
(load "~/.emacs.d/configs/hotkeys.el")
(load "~/.emacs.d/configs/functions.el")
(load "~/.emacs.d/configs/hooks.el")

;; TODO: Change *ansi-term* buffer name to running process name (or last command run)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-theme (quote nerd))
 '(package-selected-packages
   (quote
    (company-web all-the-icons ranger paredit evil-leader evil autopair projectile git-gutter-fringe git-gutter better-defaults linum-relative neotree smart-mode-line avy ivy shell-pop rainbow-delimiters ag golden-ratio with-editor company which-key use-package)))
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
 '(tide-hl-identifier-face ((t (:inherit highlight :foreground "#ff9900")))))
