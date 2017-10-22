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
  (define-key file-map (kbd "f") 'find-file)
  (define-key file-map (kbd "d") 'dired)
  )

;; Text actions map
(progn
  (define-prefix-command 'text-map)
  (define-key text-map (kbd "x") 'delete-trailing-whitespace)
  (define-key text-map (kbd "t") 'toggle-truncate-lines)
  )

(global-set-key (kbd "<C-tab>") 'evil-window-next)