;; -*- lexical-binding: t; -*-

(defun indent-buffer ()
  "Indent the whole buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defun boat/goto-scratch ()
  "Switch to the *scratch* buffer."
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*")))

(defun boat/find-init-file ()
  "Open init.el."
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))

(defun boat/reload-init ()
  "Reload init.el, re-evaluating every init-* module."
  (interactive)
  ;; init.el pulls the modules in with `require', which is a no-op for
  ;; loaded features — drop them so the requires run again.
  (setq features (seq-remove (lambda (f)
                               (string-prefix-p "init-" (symbol-name f)))
                             features))
  (let ((init-file (expand-file-name "init.el" user-emacs-directory)))
    (load-file init-file)
    (message "Reloaded %s" init-file)))

(defun boat/rg-thing-at-point ()
  "Ripgrep the project for the symbol at point."
  (interactive)
  (consult-ripgrep (and (fboundp 'projectile-project-root)
                        (projectile-project-root))
                   (thing-at-point 'symbol t)))

(defun boat/consult-line-symbol ()
  "Search lines in the current buffer for the symbol at point."
  (interactive)
  (consult-line (thing-at-point 'symbol t)))

;; Move the current line or region up/down with C-S-j / C-S-k.
(defun boat/move-text-internal (arg)
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

(defun boat/move-text-down (arg)
  "Move line or region down ARG lines."
  (interactive "*p")
  (boat/move-text-internal arg))

(defun boat/move-text-up (arg)
  "Move line or region up ARG lines."
  (interactive "*p")
  (boat/move-text-internal (- arg)))

(global-set-key [(control shift j)] 'boat/move-text-down)
(global-set-key [(control shift k)] 'boat/move-text-up)

(provide 'init-utility)
