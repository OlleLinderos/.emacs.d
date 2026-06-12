(use-package claude-code-ide
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el" :rev :newest)
  :bind ("C-c C-'" . claude-code-ide-menu)
  :config
  (setq claude-code-ide-window-side 'right)
  (claude-code-ide-emacs-tools-setup))

(define-advice claude-code-ide--setup-terminal-keybindings
    (:after () boat/evil-escape)
  (evil-local-set-key 'insert (kbd "<escape>") #'vterm-send-escape)
  (evil-local-set-key 'insert (kbd "C-<escape>") #'evil-normal-state)
  (dolist (state '(insert normal motion emacs))
    (evil-local-set-key state (kbd "C-c") #'vterm--self-insert)))

(defun boat/claude-toggle ()
  (interactive)
  (require 'claude-code-ide)
  (setq claude-code-ide-window-width (/ (frame-width) 2))
  (if (get-buffer (claude-code-ide--get-buffer-name))
      (claude-code-ide-toggle)
    (claude-code-ide)))

(define-key boat/leader-map (kbd "a") 'boat/claude-toggle)
(define-key boat/leader-map (kbd "c") 'claude-code-ide-menu)

;; C-a toggles the Claude window from anywhere
;; Scoped by projectile buffers
(defun boat/claude-buffer-p ()
  (string-match-p "\\`\\*claude-code\\[" (buffer-name)))

(define-key boat/window-nav-mode-map (kbd "C-a")
            '(menu-item "" boat/claude-toggle
                        :filter (lambda (cmd)
                                  (unless (and (derived-mode-p 'vterm-mode)
                                               (not (boat/claude-buffer-p)))
                                    cmd))))

(provide 'init-claude)
