(defun indent-buffer ()
  "Indent whole buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defun move-text-internal (arg)
  "Move line or selection up or down."
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

(defun move-text-down (arg)
  "move-text-internal implemenetation."
   (interactive "*p")
   (move-text-internal arg))

(global-set-key [(control shift j)] 'move-text-down)

(defun move-text-up (arg)
  "move-text-internal implemenetation."
   (interactive "*p")
   (move-text-internal (- arg)))

(global-set-key [(control shift k)] 'move-text-up)

(defun my-neotree-project-dir-toggle ()
  "Open NeoTree using the project root, using projectile, find-file-in-project,
or the current buffer directory."
  (interactive)
  (let* ((filepath (buffer-file-name))
         (project-dir
          (with-demoted-errors
              (cond
               ((featurep 'projectile)
                (projectile-project-root))
               ((featurep 'find-file-in-project)
                (ffip-project-root))
               (t ;; Fall back to version control root.
                (if filepath
                    (vc-call-backend
                     (vc-responsible-backend filepath) 'root filepath)
                  nil)))))
         (neo-smart-open t))

    (if (and (fboundp 'neo-global--window-exists-p)
             (neo-global--window-exists-p))
        (neotree-hide)
      (neotree-show)
      (when project-dir
        (neotree-dir project-dir))
      (when filepath
        (neotree-find filepath)))))

(defun kill-all-scratch-buffers ()
  "Initially used when using perspective, and opening a new perspective created
a scratch buffer per perspective."
  (interactive)
  (cl-letf (((symbol-function 'kill-buffer-ask) #'kill-buffer))
    (kill-matching-buffers "*scratch*")))

; (add-hook 'projectile-after-switch-project-hook #'kill-all-scratch-buffers)

(provide 'init-utility)
