; Add vim "half page up" hotkey
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))

(defun add-leader-key-map (leader-map fns)
  (let ((map (cdr leader-map)))
    (evil-leader/set-key
      (car leader-map) map)
    (progn
      (define-prefix-command map)
      (dolist (key fns)
        (define-key map
          (kbd (car key))
          (cdr key))))))

(global-set-key (kbd "<C-tab>") 'evil-window-next)

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
  "TAB" 'my-neotree-project-dir-toggle
  "'" 'toggle-terminal
  "/" 'comment-or-uncomment-region
  "a" 'avy-map
  "b" 'buffer-map
  "m" 'text-map
  "c" 'cider-map
  "d" 'docker
  "e" 'eval-buffer
  "f" 'file-map
  "h" 'haskell-map
  "s" 'swiper
  "j" 'javascript-map
  "l" 'persp-map
  "." 'toggle-map
  "g" 'magit-status
  "p" 'project-map
  "r" 'ranger
  "w" 'evil-window-map)

(global-set-key [escape] 'minibuffer-keyboard-quit)

(progn
  (define-prefix-command 'toggle-map)
  (define-key toggle-map (kbd "f") 'toggle-frame-fullscreen))

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(progn
  (define-prefix-command 'buffer-map)
  (define-key buffer-map (kbd "b") 'buffer-menu)
  (define-key buffer-map (kbd "k") 'kill-buffer)
  (define-key buffer-map (kbd "c") 'close-all-buffers))

(progn
  (define-prefix-command 'avy-map)
  (define-key avy-map (kbd "a") 'avy-goto-char)
  (define-key avy-map (kbd "w") 'avy-goto-word-1)
  (define-key avy-map (kbd "l") 'avy-goto-line)
  (define-key avy-map (kbd "c") 'avy-copy-line))

(progn
  (define-prefix-command 'project-map)
  (define-key project-map (kbd "p") 'counsel-projectile-switch-project)
  (define-key project-map (kbd "b") 'counsel-projectile-switch-to-buffer)
  (define-key project-map (kbd "f") 'counsel-projectile-find-file)
  (define-key project-map (kbd "s") 'counsel-projectile-ag)
  (define-key project-map (kbd "a") 'projectile-ag)
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
