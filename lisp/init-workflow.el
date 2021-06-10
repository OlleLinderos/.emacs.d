(use-package ivy
  :config
  (define-key ivy-minibuffer-map (kbd "C-q") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-w") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-e") 'ivy-call)
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t)
  (evil-leader/set-key "s" 'swiper))

(use-package counsel
  :config
  (setcdr (assoc 'counsel-M-x ivy-initial-inputs-alist) "")
  :init
  (evil-leader/set-key "SPC" 'counsel-M-x))

(use-package counsel-projectile)

(use-package golden-ratio)

(use-package ivy-rich
  :config (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  :init
  (ivy-rich-mode 1))

(use-package which-key :demand
  :init
  (setq which-key-idle-delay 0.25)
  (which-key-mode))

(use-package projectile
  :config
  (global-set-key (kbd "C-k") 'projectile-previous-project-buffer)
  (global-set-key (kbd "C-j") 'projectile-next-project-buffer)
  (evil-leader/set-key "p" 'project-map)
  (progn
    (define-prefix-command 'project-map)
    (define-key project-map (kbd "p") 'counsel-projectile-switch-project)
    (define-key project-map (kbd "b") 'counsel-projectile-switch-to-buffer)
    (define-key project-map (kbd "d") 'projectile-find-file-in-directory)
    (define-key project-map (kbd "f") 'counsel-projectile-find-file)
    (define-key project-map (kbd "s") 'counsel-projectile-ag)
    (define-key project-map (kbd "a") 'projectile-ag)
    (define-key project-map (kbd "k") 'projectile-kill-buffers)
    (define-key project-map (kbd ".") 'projectile-command-map)
    (define-key project-map (kbd "!") 'projectile-save-known-projects))
  :init
  (setq projectile-indexing-method 'native
        projectile-enable-caching t
        projectile-globally-ignored-directories
        '("node_modules/"
          ".yarn/"
          "bower_components/"
          "vendor/"
          ".idea/"
          "out/"
          "resources/out/"
          "target/"
          ".git/"
          "dist/"
          ".cljs_nashorn_repl"
          ".stack-work/"
          ".shadow-cljs/"
          ".tmp/"))
  (projectile-mode))

(use-package winum
  :config
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
    "9" 'winum-select-window-9)
  :init (winum-mode))

(use-package magit
  ;; :config
  ;; (define-key magit-mode-map
  ;;   (kbd "q")
  ;;   (lambda()
  ;;     "Restore window configuration and kill all Magit buffers."
  ;;     (interactive)
  ;;     (let ((buffers (magit-mode-get-buffers)))
  ;;       (magit-restore-window-configuration)
  ;;       (mapc #'kill-buffer buffers))))
  :init
  (evil-leader/set-key "g" 'magit-status)
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(use-package ag)

(use-package neotree
  :init
  (evil-leader/set-key "TAB" 'my-neotree-project-dir-toggle)
  (setq-default neo-show-hidden-files t)
  (setq neo-theme 'icons
        neo-smart-open t
        neo-window-fixed-size nil
        neo-window-width 50)
  :hook (neotree-mode . (lambda ()
                          (define-key evil-normal-state-local-map (kbd "C-q") 'evil-previous-line)
                          (define-key evil-normal-state-local-map (kbd "C-w") 'evil-next-line)
                          (define-key evil-normal-state-local-map (kbd "C-e") 'neotree-enter)
                          (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
                          (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))

(provide 'init-workflow)
