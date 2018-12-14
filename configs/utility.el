;;
;; Utility functions
;;

;; Indent whole buffer according to mode
(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

;; Move selection up or down
(defun move-text-internal (arg)
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
   (interactive "*p")
   (move-text-internal arg))

(global-set-key [(control shift down)] 'move-text-down)


(defun move-text-up (arg)
   (interactive "*p")
   (move-text-internal (- arg)))

(global-set-key [(control shift up)] 'move-text-up)


(provide 'utility)
