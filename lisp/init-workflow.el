;; -*- lexical-binding: t; -*-

;; Apparently included in Emacs 30, what a time to be alive
(which-key-mode 1)
(setq which-key-idle-delay 0.25)

(use-package projectile
  :init
  (setq projectile-globally-ignored-directories
        '("node_modules/" ".yarn/" "bower_components/" "vendor/" ".idea/"
          "out/" "target/" ".git/" "dist/" ".stack-work/" ".tmp/"))
  (projectile-mode 1)
  :config
  ;; Keep *special* buffers and magit buffers out of SPC p b.
  (add-to-list 'projectile-globally-ignored-buffers "\\`\\*.*\\*\\'")
  (add-to-list 'projectile-globally-ignored-modes "magit-.*-mode")
  ;; vterm being the exception, keep those.
  (define-advice projectile-ignored-buffer-p (:around (orig buffer) keep-vterm)
    (and (not (provided-mode-derived-p
               (buffer-local-value 'major-mode buffer) 'vterm-mode))
         (funcall orig buffer))))

(use-package ace-window
  :init
  (setq aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9 ?0)
        aw-scope 'frame))

(defun boat/select-window-by-number (n)
  (let ((win (nth (1- n) (aw-window-list))))
    (when (window-live-p win)
      (aw-switch-to-window win))))

;; Set keybinds SPC 1...9 to jump between open windows
(dotimes (i 9)
  (let ((n (1+ i)))
    (define-key boat/leader-map (kbd (number-to-string n))
                (lambda () (interactive) (boat/select-window-by-number n)))))
(define-key boat/leader-map (kbd "0")
            (lambda () (interactive) (boat/select-window-by-number 10)))

(use-package treemacs
  :defer t)
(use-package treemacs-evil
  :after (treemacs evil))
(use-package treemacs-projectile
  :after (treemacs projectile))

(provide 'init-workflow)
