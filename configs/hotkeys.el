;; Everything evil
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(global-set-key (kbd "<C-tab>") 'evil-window-next)

(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))

(evil-leader/set-leader "SPC")
(evil-leader/set-key
  "SPC" 'counsel-M-x
  "'" 'shell-pop
  "TAB" 'open-neotree
  "/" 'comment-region
  "\\\\" 'uncomment-region
  "b" 'buffer-menu
  "d" 'text-map
  "c" 'cider-map
  "f" 'file-map
  "s" 'swiper
  "j" 'avy-map
  "t" 'toggle-map
  "g" 'magit-status
  "p" 'project-map
  "r" 'ranger
  "w" 'evil-window-map)

(global-set-key [escape] 'minibuffer-keyboard-quit)

;; Toggle
(progn
  (define-prefix-command 'toggle-map)
  (define-key toggle-map (kbd "f") 'toggle-frame-fullscreen))

;; Cider
(progn
  (define-prefix-command 'cider-map)
  (define-key cider-map (kbd "e") 'cider-eval-defun-at-point)
  (define-key cider-map (kbd "j") 'jackin-map))
(progn
  (define-prefix-command 'jackin-map)
  (define-key jackin-map (kbd "s") 'cider-jack-in-clojurescript)
  (define-key jackin-map (kbd "c") 'cider-jack-in-clojure))

;; Avy
(progn
  (define-prefix-command 'avy-map)
  (define-key avy-map (kbd "j") 'avy-goto-char)
  (define-key avy-map (kbd "w") 'avy-goto-word-1)
  (define-key avy-map (kbd "l") 'avy-goto-line)
  (define-key avy-map (kbd "c") 'avy-copy-line))

;; Projectile Counsel
(progn
  (define-prefix-command 'project-map)
  (define-key project-map (kbd "p") 'counsel-projectile-switch-project)
  (define-key project-map (kbd "f") 'counsel-projectile-find-file)
  (define-key project-map (kbd "s") 'counsel-projectile-ag)
  (define-key project-map (kbd ".") 'projectile-command-map)
  (define-key project-map (kbd "!") 'projectile-save-known-projects))

;; General file-map
(progn
  (define-prefix-command 'file-map)
  (define-key file-map (kbd "f") 'counsel-find-file)
  (define-key file-map (kbd "d") 'dired)
  (define-key file-map (kbd "e")
    (lambda() (interactive)
      (find-file "~/.emacs.d/init.el"))))

;; Text actions map
(progn
  (define-prefix-command 'text-map)
  (define-key text-map (kbd "x") 'delete-trailing-whitespace)
  (define-key text-map (kbd "t") 'toggle-truncate-lines))

