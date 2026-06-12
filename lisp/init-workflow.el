;;; -*- lexical-binding: t; -*-

(use-package which-key
  :ensure nil ; built-in since Emacs 30
  :init
  (setq which-key-idle-delay 0.25)
  :config
  (which-key-mode 1))

(use-package projectile
  :init
  (setq projectile-globally-ignored-directories
        '("node_modules/" ".yarn/" "bower_components/" "vendor/" ".idea/"
          "out/" "target/" ".git/" "dist/" ".stack-work/" ".tmp/"))
  (projectile-mode 1)
  :config
  (add-to-list 'projectile-globally-ignored-buffers "\\`\\*.*\\*\\'")
  (add-to-list 'projectile-globally-ignored-modes "magit-.*-mode")
  (setq projectile-ignored-project-function #'mine/linked-worktree-at)
  (define-advice projectile-add-known-project
      (:filter-args (args) worktree-container)
    (list (or (mine/worktree-container (car args)) (car args))))
  (define-advice projectile-switch-project-by-name
      (:filter-args (args) worktree-container)
    (let ((main (concat (file-name-as-directory (car args)) "main/")))
      (if (and (not (file-remote-p main))
               (file-directory-p (expand-file-name ".git" main)))
          (cons (mine/read-worktree main) (cdr args))
        args)))
  (setq projectile-project-name-function #'mine/projectile-project-name)
  (dolist (project (projectile-known-projects))
    (let ((container (mine/worktree-container project)))
      (cond (container
             (projectile-remove-known-project project)
             (projectile-add-known-project container))
            ((mine/linked-worktree-at project)
             (projectile-remove-known-project project))))))

(defun mine/projectile-project-name (root)
  (let ((container (mine/worktree-container root)))
    (if (and container (not (mine/linked-worktree-at root)))
        (file-name-nondirectory (directory-file-name container))
      (projectile-default-project-name root))))

(defun mine/read-worktree (repo)
  (require 'magit)
  (let* ((current (and (not (file-remote-p default-directory))
                       (locate-dominating-file default-directory ".git")))
         (current (and current
                       (file-name-as-directory (expand-file-name current))))
         (default-directory (file-name-as-directory (expand-file-name repo)))
         (top (or (magit-toplevel)
                  (user-error "Not inside a git repository")))
         (base (file-name-directory (directory-file-name top)))
         (worktrees
          (or (seq-remove (lambda (wt) (nth 3 wt)) ; bare: nothing to open
                          (magit-list-worktrees))
              (user-error "No worktrees to open in this repository")))
         (table (mapcar (lambda (wt)
                          (cons (file-relative-name
                                 (directory-file-name (car wt)) base)
                                wt))
                        worktrees))
         (completion-extra-properties
          (list :annotation-function
                (lambda (cand)
                  (let ((wt (cdr (assoc cand table))))
                    (concat "  " (or (nth 2 wt) "(detached)")
                            (and (equal (file-name-as-directory
                                         (expand-file-name (car wt)))
                                        current)
                                 "  (current)")))))))
    (file-name-as-directory
     (abbreviate-file-name
      (cadr (assoc (completing-read "Worktree: " table nil t) table))))))

(defun mine/projectile-switch-worktree (worktree)
  (interactive (list (mine/read-worktree default-directory)))
  (let ((projectile-switch-project-action
         (lambda ()
           (let ((readme (or (car (file-expand-wildcards "README.md"))
                             (car (file-expand-wildcards "README*")))))
             (if readme (find-file readme) (dired default-directory))))))
    (projectile-switch-project-by-name worktree)))

(defvar-local mine/worktrees--main nil)

(defun mine/worktrees--dirty-p (path)
  (and (file-directory-p path)
       (let ((default-directory (file-name-as-directory path)))
         (magit-git-string "status" "--porcelain"))))

(defun mine/worktrees--refresh ()
  (let* ((default-directory mine/worktrees--main)
         (base (file-name-directory (directory-file-name mine/worktrees--main))))
    (setq tabulated-list-entries
          (mapcar
           (lambda (wt)
             (let ((path (file-name-as-directory (expand-file-name (car wt)))))
               (list path
                     (vector
                      (file-relative-name (directory-file-name path) base)
                      (or (nth 2 wt) (if (nth 3 wt) "(bare)" "(detached)"))
                      (cond ((equal path mine/worktrees--main) "main")
                            ((nth 6 wt) "prunable")
                            ((nth 5 wt) "locked")
                            ((mine/worktrees--dirty-p path)
                             (propertize "dirty" 'face 'warning))
                            (t "clean"))
                      (abbreviate-file-name path)))))
           (magit-list-worktrees)))))

(defvar mine/worktrees-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map tabulated-list-mode-map)
    (define-key map (kbd "d") #'mine/worktrees-flag-delete)
    (define-key map (kbd "u") #'mine/worktrees-unflag)
    (define-key map (kbd "U") #'mine/worktrees-unflag-all)
    (define-key map (kbd "x") #'mine/worktrees-execute)
    (define-key map (kbd "D") #'mine/worktrees-delete)
    (define-key map (kbd "RET") #'mine/worktrees-visit)
    map))

(define-derived-mode mine/worktrees-mode tabulated-list-mode "Worktrees"
  (setq tabulated-list-format [("Worktree" 32 t) ("Branch" 40 t)
                               ("State" 9 t) ("Path" 0 t)]
        tabulated-list-padding 2)
  (add-hook 'tabulated-list-revert-hook #'mine/worktrees--refresh nil t)
  (tabulated-list-init-header))

(with-eval-after-load 'evil
  (evil-define-key 'normal mine/worktrees-mode-map
    (kbd "d") #'mine/worktrees-flag-delete
    (kbd "u") #'mine/worktrees-unflag
    (kbd "U") #'mine/worktrees-unflag-all
    (kbd "x") #'mine/worktrees-execute
    (kbd "D") #'mine/worktrees-delete
    (kbd "RET") #'mine/worktrees-visit
    (kbd "gr") #'revert-buffer
    (kbd "q") #'quit-window))

(defun mine/worktrees ()
  (interactive)
  (require 'magit)
  (let* ((container-main (expand-file-name "main/" default-directory))
         (default-directory
          (if (and (not (magit-toplevel))
                   (file-directory-p (expand-file-name ".git" container-main)))
              container-main
            default-directory))
         (main (file-name-as-directory
                (expand-file-name
                 (car (or (car (magit-list-worktrees))
                          (user-error "Not inside a git repository"))))))
         (name (file-name-nondirectory
                (directory-file-name
                 (or (mine/worktree-container main) main)))))
    (with-current-buffer (get-buffer-create (format "*worktrees: %s*" name))
      (mine/worktrees-mode)
      (setq mine/worktrees--main main
            default-directory main)
      (mine/worktrees--refresh)
      (tabulated-list-print)
      (pop-to-buffer-same-window (current-buffer)))))

(defun mine/worktrees--id ()
  (or (tabulated-list-get-id) (user-error "No worktree on this line")))

(defun mine/worktrees-flag-delete ()
  (interactive)
  (when (equal (mine/worktrees--id) mine/worktrees--main)
    (user-error "The main checkout can't be deleted"))
  (tabulated-list-put-tag "D" t))

(defun mine/worktrees-unflag ()
  (interactive)
  (mine/worktrees--id)
  (tabulated-list-put-tag " " t))

(defun mine/worktrees-unflag-all ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (tabulated-list-put-tag " " t))))

(defun mine/worktrees--flagged ()
  (let (flagged)
    (save-excursion
      (goto-char (point-min))
      (while (not (eobp))
        (when (eq (char-after) ?D)
          (push (tabulated-list-get-id) flagged))
        (forward-line 1)))
    (nreverse flagged)))

(defun mine/worktrees--kill-buffers (path)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (when (and (string-prefix-p path (expand-file-name default-directory))
                 (if buffer-file-name
                     (not (buffer-modified-p))
                   (derived-mode-p 'dired-mode)))
        (kill-buffer buffer)))))

(defun mine/worktrees--delete (paths)
  (let ((default-directory mine/worktrees--main)
        (names (mapcar (lambda (path)
                         (file-name-nondirectory (directory-file-name path)))
                       paths))
        deleted failed)
    (unless (yes-or-no-p (format "Delete %s %s? "
                                 (if (cdr paths) "worktrees" "worktree")
                                 (string-join names ", ")))
      (user-error "Nothing deleted"))
    (dolist (path paths)
      (let* ((name (file-name-nondirectory (directory-file-name path)))
             (dirty (mine/worktrees--dirty-p path)))
        (when (or (not dirty)
                  (yes-or-no-p
                   (format "%s has modified or untracked files that will be lost.  Delete anyway? "
                           name)))
          (with-temp-buffer
            (if (zerop (apply #'process-file magit-git-executable nil t nil
                              "worktree" "remove"
                              (append (and dirty '("--force"))
                                      (list (directory-file-name path)))))
                (progn (push name deleted)
                       (mine/worktrees--kill-buffers path))
              (push (format "%s: %s" name (string-trim (buffer-string)))
                    failed))))))
    (revert-buffer)
    (if failed
        (message "Failed to delete %s" (string-join (nreverse failed) "; "))
      (message "Deleted %s" (if deleted
                                (string-join (nreverse deleted) ", ")
                              "nothing")))))

(defun mine/worktrees-execute ()
  (interactive)
  (mine/worktrees--delete
   (or (mine/worktrees--flagged)
       (user-error "No worktrees flagged for deletion"))))

(defun mine/worktrees-delete ()
  (interactive)
  (let ((path (mine/worktrees--id)))
    (when (equal path mine/worktrees--main)
      (user-error "The main checkout can't be deleted"))
    (mine/worktrees--delete (list path))))

(defun mine/worktrees-visit ()
  (interactive)
  (mine/projectile-switch-worktree (abbreviate-file-name (mine/worktrees--id))))

(use-package ace-window
  :init
  (setq aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9 ?0)
        aw-scope 'frame))

(defun mine/select-window-by-number (n)
  (let ((win (nth (1- n) (aw-window-list))))
    (when (window-live-p win)
      (aw-switch-to-window win))))

(use-package magit
  :defer t
  :init
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1
        magit-blame-echo-style 'margin))

(defun mine/magit-visit-file-other-window-bindings ()
  (define-key magit-file-section-map (kbd "RET")
              #'magit-diff-visit-worktree-file-other-window)
  (define-key magit-hunk-section-map (kbd "RET")
              #'magit-diff-visit-worktree-file-other-window))
(with-eval-after-load 'magit-diff
  (add-hook 'magit-mode-hook #'mine/magit-visit-file-other-window-bindings))

(use-package diff-hl
  :init
  (setq diff-hl-side 'left
        diff-hl-show-hunk-inline-smart-lines nil)
  :config
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode 1)
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)
  (define-key evil-normal-state-map (kbd "C-g") #'diff-hl-show-hunk))

(defun mine/dired-enter-directory ()
  "Descend into the directory at point; do nothing on a file."
  (interactive)
  (let ((file (dired-get-filename nil t)))
    (when (and file (file-directory-p file))
      (dired-find-file))))

(use-package dirvish
  :init
  (dirvish-override-dired-mode 1)
  (setq dirvish-attributes '(file-size vc-state)
        dirvish-side-attributes '(vc-state)
        dirvish-reuse-session t
        dirvish-use-header-line nil
        dirvish-quick-access-entries
        '(("h" "~/" "home")
          ("e" "~/.emacs.d/" "emacs.d")
          ("d" "~/Downloads/" "downloads")))
  :config
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
  (dirvish-side-follow-mode 1)
  (with-eval-after-load 'evil
    (evil-define-key 'normal dirvish-mode-map
      (kbd "H") 'dired-up-directory
      (kbd "h") 'dired-up-directory
      (kbd "L") 'mine/dired-enter-directory
      (kbd "l") 'mine/dired-enter-directory
      (kbd "RET") 'dired-find-file
      (kbd "TAB") 'dirvish-subtree-toggle
      (kbd "a") 'dirvish-quick-access
      (kbd "y") 'dirvish-yank-menu
      (kbd "s") 'dirvish-quicksort
      (kbd "f") 'dirvish-file-info-menu
      (kbd "q") 'dirvish-quit)))

(use-package direnv)

(provide 'init-workflow)
