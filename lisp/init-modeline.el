;; -*- lexical-binding: t; -*-

(defun boat/mode-line-buffer-id ()
  "Project-relative path of the buffer's file"
  (let* ((file buffer-file-name)
         (root (and file
                    (fboundp 'projectile-project-root)
                    (ignore-errors (projectile-project-root)))))
    (propertize (if (and file root)
                    (file-relative-name file root)
                  (buffer-name))
                'face 'mode-line-buffer-id)))

(defun boat/mode-line-project ()
  "Current projectile project name, empty outside projects."
  (if (and (fboundp 'projectile-project-p) (projectile-project-p))
      (projectile-project-name)
    ""))

(defun boat/mode-line-vc ()
  "Git branch name only"
  (if vc-mode
      (replace-regexp-in-string "\\`[A-Za-z]+[-:@!?^]" ""
                                (string-trim (substring-no-properties vc-mode)))
    ""))

(defun boat/mode-line-flycheck ()
  (if (and (bound-and-true-p flycheck-mode) flycheck-current-errors)
      (let-alist (flycheck-count-errors flycheck-current-errors)
        (concat
         (when .error (propertize (format "✖ %d " .error) 'face 'error))
         (when .warning (propertize (format "▲ %d " .warning) 'face 'warning))
         (when .info (propertize (format "● %d " .info) 'face 'success))))
    ""))

(setq-default mode-line-format
              '(" "
                (:eval (if (and buffer-file-name (buffer-modified-p)) "● " "  "))
                (:eval (boat/mode-line-buffer-id))
                "  "
                (:eval (boat/mode-line-project))
                "  "
                (:eval (boat/mode-line-vc))
                mode-line-format-right-align
                (:eval (boat/mode-line-flycheck))
                " "))

(when (fboundp 'catppuccin-color)
  (set-face-attribute 'mode-line-buffer-id nil
                      :foreground (catppuccin-color 'red))
  (set-face-attribute 'mode-line-inactive nil
                      :background (catppuccin-color 'crust)))

(provide 'init-modeline)
