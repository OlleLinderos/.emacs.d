(use-package multi-term
  :config
  (setq multi-term-program "/bin/zsh"
        multi-term-dedicated-window-height 18
        multi-term-dedicated-max-window-height 18))

(defun toggle-dedicated-terminal ()
  (interactive)
  (multi-term-dedicated-toggle)
  (multi-term-dedicated-select))


(evil-leader/set-key "'" 'toggle-dedicated-terminal)

(evil-leader/set-key "t" 'term-map)
(progn
  (define-prefix-command 'term-map)
  (define-key term-map (kbd "t") 'multi-term)
  (define-key term-map (kbd "n") 'multi-term-next)
  (define-key term-map (kbd "p") 'multi-term-prev))

(provide 'init-term)
