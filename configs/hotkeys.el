(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(global-set-key (kbd "<C-tab>") 'evil-window-next)

(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))

(evil-leader/set-leader "SPC")
(evil-leader/set-key
  "0" 'winum-select-window-0
  "1" 'winum-select-window-1 
  "2" 'winum-select-window-2 
  "3" 'winum-select-window-3 
  "4" 'winum-select-window-4 
  "5" 'winum-select-window-5 
  "6" 'winum-select-window-6 
  "7" 'winum-select-window-7 
  "8" 'winum-select-window-8 
  "9" 'winum-select-window-9 
  "SPC" 'counsel-M-x
  "TAB" 'open-neotree
  "'" 'toggle-terminal
  "/" 'comment-or-uncomment-region
  "b" 'buffer-menu
  "m" 'text-map
  "c" 'cider-map
  "d" 'docker
  "f" 'file-map
  "s" 'swiper
  "j" 'javascript-map
  "l" 'persp-map
  "." 'toggle-map
  "g" 'magit-status
  "p" 'project-map
  "t" 'terminal-map
  "r" 'ranger
  "w" 'evil-window-map)

(global-set-key [escape] 'minibuffer-keyboard-quit)

(progn
  (define-prefix-command 'toggle-map)
  (define-key toggle-map (kbd "f") 'toggle-frame-fullscreen))

(progn
  (define-prefix-command 'cider-map)
  (define-key cider-map (kbd "e") 'cider-eval-defun-at-point)
  (define-key cider-map (kbd "j") 'jackin-map))

(progn
  (define-prefix-command 'jackin-map)
  (define-key jackin-map (kbd "s") 'cider-jack-in-clojurescript)
  (define-key jackin-map (kbd "c") 'cider-jack-in-clojure))

(progn
  (define-prefix-command 'avy-map)
  (define-key avy-map (kbd "j") 'avy-goto-char)
  (define-key avy-map (kbd "w") 'avy-goto-word-1)
  (define-key avy-map (kbd "l") 'avy-goto-line)
  (define-key avy-map (kbd "c") 'avy-copy-line))

(progn
  (define-prefix-command 'project-map)
  (define-key project-map (kbd "p") 'counsel-projectile-switch-project)
  (define-key project-map (kbd "f") 'counsel-projectile-find-file)
  (define-key project-map (kbd "s") 'counsel-projectile-ag)
  (define-key project-map (kbd ".") 'projectile-command-map)
  (define-key project-map (kbd "!") 'projectile-save-known-projects))

(progn
  (define-prefix-command 'file-map)
  (define-key file-map (kbd "f") 'counsel-find-file)
  (define-key file-map (kbd "d") 'dired)
  (define-key file-map (kbd "e")
    (lambda() (interactive)
      (find-file "~/.emacs.d/init.el"))))

(progn
  (define-prefix-command 'javascript-map)
  (define-key javascript-map (kbd "a") 'angular-map)
  (define-key javascript-map (kbd "t") 'tide-map))

(progn
  (define-prefix-command 'tide-map)
  (define-key tide-map (kbd "d") 'tide-jump-to-definition)
  (define-key tide-map (kbd "r") 'tide-rename-symbol))

(progn
  (define-prefix-command 'angular-map)
  (define-key angular-map (kbd "c") 'ng2-open-counterpart))

(progn
  (define-prefix-command 'terminal-map)
  (define-key terminal-map (kbd "t") 'multi-term-)
  (define-key terminal-map (kbd "n") 'multi-term-next)
  (define-key terminal-map (kbd "p") 'multi-term-prev))

(progn
  (define-prefix-command 'persp-map)
  (define-key persp-map (kbd "p") 'projectile-persp-switch-project)
  (define-key persp-map (kbd "l") 'persp-switch)
  (define-key persp-map (kbd "k") 'persp-kill)
  (define-key persp-map (kbd "b") 'ido-switch-buffer))

(progn
  (define-prefix-command 'text-map)
  (define-key text-map (kbd "x") 'delete-trailing-whitespace)
  (define-key text-map (kbd "i") 'indent-buffer)
  (define-key text-map (kbd "t") 'toggle-truncate-lines))


(provide 'hotkeys)
