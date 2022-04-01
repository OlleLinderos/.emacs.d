(use-package vterm)

(use-package multi-vterm
  :hook (vterm-mode . (lambda () (read-only-mode -1)))

  :config

  (define-key vterm-mode-map [return]                      #'vterm-send-return)

  (setq vterm-keymap-exceptions nil)
  (evil-define-key 'insert vterm-mode-map (kbd "C-e")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-f")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-a")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-v")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-b")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-w")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-u")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-n")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-m")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-p")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-r")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-t")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-g")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-c")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-SPC")    #'vterm--self-insert)
  (evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'vterm--self-insert)

  (evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
  (evil-define-key 'normal vterm-mode-map (kbd "o")        #'evil-insert-resume)
  (evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume)

  (evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'evil-scroll-down)

  (evil-define-key 'normal vterm-mode-map (kbd "y")        #'evil-yank)
  (evil-define-key 'normal vterm-mode-map (kbd "p")        #'term-paste)

  (evil-define-key 'normal vterm-mode-map (kbd "C-k") 'projectile-previous-project-buffer)
  (evil-define-key 'normal vterm-mode-map (kbd "C-j") 'projectile-next-project-buffer))

(evil-leader/set-key "t" 'term-map)
(progn
  (define-prefix-command 'term-map)
  (define-key term-map (kbd "t") 'multi-vterm)
  (define-key term-map (kbd "n") 'multi-vterm-next)
  (define-key term-map (kbd "p") 'multi-vterm-prev))

(provide 'init-term)
