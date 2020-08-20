(use-package multi-term
  :config
  (setq multi-term-program "/bin/zsh"
        multi-term-dedicated-window-height 18
        multi-term-dedicated-max-window-height 18))

(defun toggle-terminal ()
  (interactive)
  (multi-term-dedicated-toggle)
  (multi-term-dedicated-select))

(add-leader-key-map
 '("k" . terminal-map
   '(("t" . multi-term)
     ("n" . multi-term-next)
     ("p" . multi-term-prev))))

(provide 'init-term)
