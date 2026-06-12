;; -*- lexical-binding: t; -*-

(use-package vterm
  :init
  (setq vterm-always-compile-module t))

(use-package multi-vterm
  :hook (vterm-mode . (lambda () (read-only-mode -1)))

  :config

  (define-key vterm-mode-map [return] #'vterm-send-return)

  (setq vterm-keymap-exceptions nil)
  ;; Pass the usual C-* keys straight through to the shell.
  (dolist (key '("C-e" "C-f" "C-a" "C-v" "C-b" "C-w" "C-u" "C-d" "C-n"
                 "C-m" "C-p" "C-r" "C-t" "C-g" "C-c" "C-SPC"))
    (evil-define-key 'insert vterm-mode-map (kbd key) #'vterm--self-insert))

  (evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
  (evil-define-key 'normal vterm-mode-map (kbd "o")        #'evil-insert-resume)
  (evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume)

  (evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'evil-scroll-down)

  (evil-define-key 'normal vterm-mode-map (kbd "y")        #'evil-yank)
  (evil-define-key 'normal vterm-mode-map (kbd "p")        #'vterm-yank)
  (evil-define-key 'normal vterm-mode-map (kbd "P")        #'vterm-yank)
  (evil-define-key 'normal vterm-mode-map (kbd "M-y")      #'vterm-yank-pop)

  (evil-define-key 'normal vterm-mode-map (kbd "C-k") 'projectile-previous-project-buffer)
  (evil-define-key 'normal vterm-mode-map (kbd "C-j") 'projectile-next-project-buffer))

;; Terminals: SPC t.
(define-prefix-command 'term-map)
(define-key boat/leader-map (kbd "t") 'term-map)
(define-key term-map (kbd "t") 'multi-vterm)
(define-key term-map (kbd "n") 'multi-vterm-next)
(define-key term-map (kbd "p") 'multi-vterm-prev)

(provide 'init-term)
;;; init-term.el ends here
