(evil-leader/set-key "b" 'buffer-map)
(progn
  (define-prefix-command 'buffer-map)
  (define-key buffer-map (kbd "b") 'counsel-projectile-switch-to-buffer)
  (define-key buffer-map (kbd "a") 'buffer-menu)
  (define-key buffer-map (kbd "k") 'kill-buffer)
  (define-key buffer-map (kbd "c")
    (lambda()
      (interactive)
      (mapc 'kill-buffer (buffer-list)))))

(evil-leader/set-key "f" 'file-map)
(progn
  (define-prefix-command 'file-map)
  (define-key file-map (kbd "f") 'counsel-find-file)
  (define-key file-map (kbd "d") 'dired)
  (define-key file-map (kbd "e")
    (lambda()
      (interactive)
      (find-file "~/.emacs.d/init.el"))))

(evil-leader/set-key "m" 'text-map)
(progn
  (define-prefix-command 'text-map)
  (define-key text-map (kbd "x") 'delete-trailing-whitespace)
  (define-key text-map (kbd "i") 'indent-buffer)
  (define-key text-map (kbd "t") 'toggle-truncate-lines))

(provide 'init-hotkeys)
