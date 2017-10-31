(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Toggle
(progn
  (define-prefix-command 'toggle-map)
  (define-key toggle-map (kbd "f") 'toggle-frame-fullscreen)
  )

;; Avy
(progn
  (define-prefix-command 'avy-map)
  (define-key avy-map (kbd "j") 'avy-goto-char)
  (define-key avy-map (kbd "w") 'avy-goto-word-1)
  (define-key avy-map (kbd "l") 'avy-goto-line)
  (define-key avy-map (kbd "c") 'avy-copy-line)
  )

;; Projectile Counsel
(progn
  (define-prefix-command 'project-map)
  (define-key project-map (kbd "p") 'counsel-projectile-switch-project)
  (define-key project-map (kbd "f") 'counsel-projectile-find-file)
  (define-key project-map (kbd "s") 'counsel-projectile-ag)
  (define-key project-map (kbd ".") 'projectile-command-map)
  (define-key project-map (kbd "!") 'projectile-save-known-projects)
  )

;; Multiple Cursors
(progn
  (define-prefix-command 'multiple-cursors-map)
  (define-key multiple-cursors-map (kbd "j") 'evil-mc-make-cursor-move-next-line)
  (define-key multiple-cursors-map (kbd "r") 'evil-mc-undo-all-cursors)
  (define-key multiple-cursors-map (kbd "h") 'evil-mc-make-cursor-at-pos)
  )

;; General file-map
(progn
  (define-prefix-command 'file-map)
  (define-key file-map (kbd "f") 'counsel-find-file)
  (define-key file-map (kbd "d") 'counsel-projectile-find-dir)
  (define-key file-map (kbd "e")
    (lambda() (interactive)
      (find-file "~/.emacs.d/init.el")))
  )

;; Text actions map
(progn
  (define-prefix-command 'text-map)
  (define-key text-map (kbd "x") 'delete-trailing-whitespace)
  (define-key text-map (kbd "t") 'toggle-truncate-lines)
  )

(global-set-key (kbd "<C-tab>") 'evil-window-next)
