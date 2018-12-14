;;
;; Theme
;;
(setq nord-comment-brightness 15)
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)
(set-face-attribute 'fringe nil :background nil)

(when (member "Space Mono" (font-family-list))
  (set-face-attribute 'default nil :font "Space Mono" :height 140))

(setq inhibit-splash-screen t
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


;; A nicer mode line
(use-package smart-mode-line)
(require 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'respectful)
(sml/setup)

;; mx install all the icons font
(use-package all-the-icons)
(require 'all-the-icons)

;; Replace with Hax?
(setq custom-safe-themes t)
(use-package nord-theme)
(require 'nord-theme)


(provide 'theme)