;;; -*- lexical-binding: t; -*-

(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defun mine/goto-scratch ()
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*")))

(defun mine/find-init-file ()
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))

(defun mine/reload-init ()
  (interactive)
  (setq features (seq-remove (lambda (f)
                               (string-prefix-p "init-" (symbol-name f)))
                             features))
  (let ((init-file (expand-file-name "init.el" user-emacs-directory)))
    (load-file init-file)
    (message "Reloaded %s" init-file)))

(defun mine/rg-thing-at-point ()
  (interactive)
  (consult-ripgrep (and (fboundp 'projectile-project-root)
                        (projectile-project-root))
                   (thing-at-point 'symbol t)))

(defun mine/consult-line-symbol ()
  (interactive)
  (consult-line (thing-at-point 'symbol t)))

(defun mine/move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
        (transpose-lines arg))
      (forward-line -1)))))

(defun mine/move-text-down (arg)
  (interactive "*p")
  (mine/move-text-internal arg))

(defun mine/move-text-up (arg)
  (interactive "*p")
  (mine/move-text-internal (- arg)))

(global-set-key [(control shift j)] 'mine/move-text-down)
(global-set-key [(control shift k)] 'mine/move-text-up)

(provide 'init-utility)
