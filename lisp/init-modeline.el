;;; -*- lexical-binding: t; -*-

(defun mine/mode-line-buffer-id ()
  (let* ((file buffer-file-name)
         (root (and file
                    (fboundp 'projectile-project-root)
                    (ignore-errors (projectile-project-root)))))
    (propertize (if (and file root)
                    (file-relative-name file root)
                  (buffer-name))
                'face 'mode-line-buffer-id)))

(defvar-local mine/--worktree-cache nil)

(defun mine/--worktree-gitdir (root)
  (let ((dotgit (expand-file-name ".git" root)))
    (and (not (file-remote-p dotgit))
         (file-regular-p dotgit)
         (with-temp-buffer
           (insert-file-contents dotgit)
           (when (looking-at "gitdir: \\(.*\\)/worktrees/[^/\n]+$")
             (directory-file-name (match-string 1)))))))

(defun mine/worktree-container (root)
  (unless (file-remote-p root)
    (let* ((gitdir (mine/--worktree-gitdir root))
           (main (directory-file-name
                  (cond ((null gitdir) (expand-file-name root))
                        ((equal (file-name-nondirectory gitdir) ".git")
                         (file-name-directory gitdir))
                        (t gitdir)))))  ; bare repo, never a container
      (and (equal (file-name-nondirectory main) "main")
           (file-directory-p (expand-file-name ".git" main))
           (file-name-directory main)))))

(defun mine/linked-worktree-at (root)
  (when-let* ((gitdir (mine/--worktree-gitdir root)))
    (let ((base (file-name-nondirectory gitdir))
          (container (mine/worktree-container root)))
      (cons (cond (container
                   (file-name-nondirectory (directory-file-name container)))
                  ((equal base ".git")
                   (file-name-nondirectory
                    (directory-file-name (file-name-directory gitdir))))
                  (t (string-remove-suffix ".git" base)))
            (file-name-nondirectory (directory-file-name root))))))

(defun mine/linked-worktree ()
  (if (equal (car mine/--worktree-cache) default-directory)
      (cdr mine/--worktree-cache)
    (let* ((root (and (not (file-remote-p default-directory))
                      (locate-dominating-file default-directory ".git")))
           (info (and root
                      (or (mine/linked-worktree-at root)
                          ;; Main checkout of a `REPO/main' layout.
                          (when-let* ((container (mine/worktree-container root)))
                            (cons (file-name-nondirectory
                                   (directory-file-name container))
                                  (file-name-nondirectory
                                   (directory-file-name
                                    (expand-file-name root)))))))))
      (setq mine/--worktree-cache (cons default-directory info))
      info)))

(defun mine/mode-line-project ()
  (if-let* ((wt (or (mine/linked-worktree)
                    ;; Notes show the worktree they are about.
                    (and (fboundp 'mine/notes-context) (mine/notes-context)))))
      (if (cdr wt)
          (concat (car wt) "  "
                  (propertize "worktree " 'face 'shadow)
                  (propertize (cdr wt) 'face 'bold))
        (car wt))
    (if (and (fboundp 'projectile-project-p) (projectile-project-p))
        (projectile-project-name)
      "")))

(defun mine/mode-line-vc ()
  (if vc-mode
      (concat
       (propertize "branch " 'face 'shadow)
       (replace-regexp-in-string "\\`[A-Za-z]+[-:@!?^]" ""
                                 (string-trim (substring-no-properties vc-mode))))
    ""))

(defun mine/mode-line-flycheck ()
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
                (:eval (mine/mode-line-buffer-id))
                "  "
                (:eval (mine/mode-line-project))
                "  "
                (:eval (mine/mode-line-vc))
                mode-line-format-right-align
                (:eval (mine/mode-line-flycheck))
                " "))

(when (fboundp 'catppuccin-color)
  (set-face-attribute 'mode-line-buffer-id nil
                      :foreground (catppuccin-color 'red))
  (set-face-attribute 'mode-line-inactive nil
                      :background (catppuccin-color 'crust)))

(provide 'init-modeline)
