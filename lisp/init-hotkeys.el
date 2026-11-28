;;; -*- lexical-binding: t; -*-

;; Top-level singles.
(define-key mine/leader-map (kbd "SPC") 'execute-extended-command)
(define-key mine/leader-map (kbd "TAB") 'evil-switch-to-windows-last-buffer)
(define-key mine/leader-map (kbd "/") 'consult-ripgrep)
(define-key mine/leader-map (kbd ";") 'evilnc-comment-operator)
(define-key mine/leader-map (kbd ",") 'evil-avy-goto-char)
(define-key mine/leader-map (kbd "u") 'universal-argument)
(define-key mine/leader-map (kbd "s") 'consult-line)
(define-key mine/leader-map (kbd "C-s") 'mine/consult-line-symbol)
(define-key mine/leader-map (kbd "h") 'help-command)

;; Buffers.
(define-prefix-command 'buffer-map)
(define-key mine/leader-map (kbd "b") 'buffer-map)
(define-key buffer-map (kbd "b") 'consult-buffer)
(define-key buffer-map (kbd "d") 'kill-current-buffer)
(define-key buffer-map (kbd "k") 'kill-buffer)
(define-key buffer-map (kbd "a") 'ibuffer)
(define-key buffer-map (kbd "n") 'next-buffer)
(define-key buffer-map (kbd "p") 'previous-buffer)
(define-key buffer-map (kbd "s") 'mine/goto-scratch)

;; Files.
(define-prefix-command 'file-map)
(define-key mine/leader-map (kbd "f") 'file-map)
(define-key file-map (kbd "f") 'find-file)
(define-key file-map (kbd "r") 'consult-recent-file)
(define-key file-map (kbd "s") 'save-buffer)
(define-key file-map (kbd "d") 'dirvish)
(define-key file-map (kbd "t") 'dirvish-side)

;; Config files.
(define-prefix-command 'config-map)
(define-key file-map (kbd "e") 'config-map)
(define-key config-map (kbd "d") 'mine/find-init-file)
(define-key config-map (kbd "R") 'mine/reload-init)

;; Project.
(define-prefix-command 'project-map)
(define-key mine/leader-map (kbd "p") 'project-map)
(define-key project-map (kbd "p") 'projectile-switch-project)
(define-key project-map (kbd "w") 'mine/projectile-switch-worktree)
(define-key project-map (kbd "W") 'mine/worktrees)
(define-key project-map (kbd "f") 'projectile-find-file)
(define-key project-map (kbd "b") 'consult-project-buffer)
(define-key project-map (kbd "s") 'consult-ripgrep)
(define-key project-map (kbd "C-s") 'mine/rg-thing-at-point)
(define-key project-map (kbd "d") 'projectile-find-file-in-directory)
(define-key project-map (kbd "r") 'projectile-replace-regexp)
(define-key project-map (kbd "k") 'projectile-kill-buffers)
;; dirvish-side without a path roots itself at the current project.
(define-key project-map (kbd "TAB") 'dirvish-side)
(define-key project-map (kbd "t") 'projectile-test-project)
(define-key project-map (kbd "!") 'projectile-save-known-projects)
(define-key project-map (kbd ".") 'projectile-command-map)

;; Notes.
(define-prefix-command 'notes-map)
(define-key mine/leader-map (kbd "n") 'notes-map)
(define-key notes-map (kbd "w") 'mine/notes-open)
(define-key notes-map (kbd "r") 'mine/notes-open-repo)
(define-key notes-map (kbd "d") 'mine/notes-browse)
(define-key notes-map (kbd "b") 'mine/notes-back)
(define-key notes-map (kbd "t") 'mine/org-make-todo)

;; Git.
(define-prefix-command 'git-map)
(define-key mine/leader-map (kbd "g") 'git-map)
(define-key git-map (kbd "s") 'magit-status)
(define-key git-map (kbd "b") 'magit-blame-addition)
(define-key git-map (kbd "d") 'magit-diff-buffer-file)
(define-key git-map (kbd "l") 'magit-log-buffer-file)

;; Errors (flycheck).
(define-prefix-command 'error-map)
(define-key mine/leader-map (kbd "e") 'error-map)
(define-key error-map (kbd "l") 'flycheck-list-errors)
(define-key error-map (kbd "n") 'flycheck-next-error)
(define-key error-map (kbd "p") 'flycheck-previous-error)
(define-key error-map (kbd "v") 'flycheck-verify-setup)

;; Text.
(define-prefix-command 'text-map)
(define-key mine/leader-map (kbd "m") 'text-map)
(define-key text-map (kbd "x") 'delete-trailing-whitespace)
(define-key text-map (kbd "i") 'indent-buffer)
(define-key text-map (kbd "t") 'toggle-truncate-lines)
(define-key text-map (kbd "p") 'prettier-js)
(define-key text-map (kbd "e") 'eval-buffer)

;; Windows: evil's own window map (SPC w s/v/h/j/k/l...), plus the
;; spacemacs d/m habits.
(define-key evil-window-map (kbd "d") 'evil-window-delete)
(define-key evil-window-map (kbd "m") 'delete-other-windows)
(define-key mine/leader-map (kbd "w") evil-window-map)

;; Themes.
(define-prefix-command 'theme-map)
(define-key mine/leader-map (kbd "T") 'theme-map)
(define-key theme-map (kbd "T") 'mine/toggle-theme)
(define-key theme-map (kbd "s") 'mine/load-theme)

;; Quit.
(define-prefix-command 'quit-map)
(define-key mine/leader-map (kbd "q") 'quit-map)
(define-key quit-map (kbd "q") 'save-buffers-kill-terminal)
(define-key quit-map (kbd "r") 'restart-emacs)

;; Window selection by number (ace-window, spatial order).
(dotimes (i 9)
  (let ((n (1+ i)))
    (define-key mine/leader-map (kbd (number-to-string n))
                (lambda () (interactive) (mine/select-window-by-number n)))))
(define-key mine/leader-map (kbd "0")
            (lambda () (interactive) (mine/select-window-by-number 10)))

(provide 'init-hotkeys)
