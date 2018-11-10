;; This is my Emacs configuration. There are many like it, but this one is mine.


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(load "~/.emacs.d/configs/system.el")
(load "~/.emacs.d/configs/plugins.el")
(load "~/.emacs.d/configs/hotkeys.el")
(load "~/.emacs.d/configs/preferences.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-leader evil autopair projectile git-gutter-fringe git-gutter better-defaults linum-relative neotree smart-mode-line avy ivy shell-pop rainbow-delimiters ag golden-ratio with-editor company which-key use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
