;;; -*- lexical-binding: t; -*-

(defvar mine/notes-directory "~/Notes/")
(defvar mine/notes-code-directory "~/Code/")
(defvar mine/notes-file-name "notes.org")

(defun mine/notes--directory ()
  (let ((code (file-name-as-directory
               (expand-file-name mine/notes-code-directory)))
        (root (expand-file-name
               (or (and (fboundp 'projectile-project-root)
                        (projectile-project-root))
                   default-directory))))
    (file-name-as-directory
     (if (string-prefix-p code root)
         (expand-file-name (file-relative-name root code) mine/notes-directory)
       (expand-file-name mine/notes-directory)))))

(defun mine/notes-context ()
  (let ((notes (file-name-as-directory
                (expand-file-name mine/notes-directory)))
        (dir (expand-file-name default-directory)))
    (when (string-prefix-p notes dir)
      (pcase-let ((`(,app ,worktree)
                   (split-string (substring dir (length notes)) "/" t)))
        (when app
          (cons app
                (and worktree
                     (file-directory-p
                      (expand-file-name (concat app "/main/.git")
                                        mine/notes-code-directory))
                     worktree)))))))

(defvar mine/notes--origin nil)

(defun mine/notes--in-notes-p ()
  (string-prefix-p (file-name-as-directory (expand-file-name mine/notes-directory))
                   (expand-file-name default-directory)))

(defun mine/notes--remember-origin ()
  (unless (mine/notes--in-notes-p)
    (setq mine/notes--origin (current-buffer))))

(defun mine/notes-back ()
  (interactive)
  (if (buffer-live-p mine/notes--origin)
      (switch-to-buffer mine/notes--origin)
    (switch-to-buffer (other-buffer (current-buffer) t))))

(defun mine/notes--repo-directory ()
  (let* ((notes (file-name-as-directory
                 (expand-file-name mine/notes-directory)))
         (app (or (car (mine/notes-context))
                  (car (split-string
                        (substring (mine/notes--directory) (length notes))
                        "/" t)))))
    (file-name-as-directory (if app (expand-file-name app notes) notes))))

(defun mine/notes--open-in (dir)
  (let ((file (expand-file-name mine/notes-file-name dir)))
    (unless (file-exists-p file)
      (make-directory (file-name-directory file) t)
      (write-region "" nil file nil 'silent))
    (mine/notes--remember-origin)
    (find-file file)))

(defun mine/notes-open ()
  (interactive)
  (mine/notes--open-in (mine/notes--directory)))

(defun mine/notes-open-repo ()
  (interactive)
  (mine/notes--open-in (mine/notes--repo-directory)))

(defun mine/notes-browse ()
  (interactive)
  (let ((dir (mine/notes--directory)))
    (mine/notes--remember-origin)
    (dirvish (if (file-directory-p dir)
                 dir
               (expand-file-name mine/notes-directory)))))

(defun mine/org-make-todo (beg end)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (line-beginning-position) (line-end-position))))
  (unless (derived-mode-p 'org-mode)
    (user-error "Not in an org buffer"))
  (deactivate-mark)
  (let ((end (copy-marker end))
        (org-inhibit-logging t))
    (save-excursion
      (goto-char beg)
      (beginning-of-line)
      (let ((level (save-excursion
                     (cond ((org-before-first-heading-p) 1)
                           ((progn (org-back-to-heading t)
                                   (org-get-todo-state))
                            (org-current-level))
                           (t (1+ (org-current-level)))))))
        (while (and (not (eobp))
                    (or (< (point) end) (= (point) beg)))
          (unless (looking-at-p "[ \t]*$")
            (unless (org-at-heading-p)
              (back-to-indentation)
              (delete-region (line-beginning-position) (point))
              (when (looking-at "\\(?:[-+*]\\|[0-9]+[.)]\\)[ \t]+")
                (replace-match ""))
              (insert (make-string level ?*) " "))
            (unless (equal (org-get-todo-state) "TODO")
              (org-todo "TODO")))
          (forward-line 1))))
    (set-marker end nil)))

(defun mine/org-tab (&optional arg)
  (interactive "P")
  (if-let* ((state (and (org-at-heading-p) (org-get-todo-state))))
      (org-todo (or (cadr (member state org-todo-keywords-1))
                    (car org-todo-keywords-1)))
    (org-cycle arg)))

(setq org-todo-keywords '((sequence "L8TR" "TODO" "WIP" "PR" "|" "DONE"))
      org-todo-keyword-faces '(("WIP" . warning) ("L8TR" . shadow)))

(setq org-fontify-done-headline nil
      org-fontify-todo-headline nil)

(defun mine/org-heading-display ()
  (add-to-list 'font-lock-extra-managed-props 'display)
  (font-lock-add-keywords
   nil
   '(("^\\(\\*+ \\)" 1
      (list 'face nil 'display
            (make-string (* 2 (- (match-end 1) (match-beginning 1) 2)) ?\s)))
     ("^\\*+ WIP\\( \\)" 1 '(face nil display (space :width 2)))
     ("^\\*+ PR\\( \\)" 1 '(face nil display (space :width 3))))))

(add-hook 'org-mode-hook #'mine/org-heading-display)

(apply #'custom-set-faces
       '(org-done ((t (:inherit success))))
       (mapcar (lambda (n)
                 `(,(intern (format "org-level-%d" n))
                   ((t (:inherit default :foreground unspecified
                        :height unspecified :weight unspecified)))))
               (number-sequence 1 8)))

(with-eval-after-load 'org
  (with-eval-after-load 'evil
    (evil-define-key 'normal org-mode-map
      (kbd "TAB") #'mine/org-tab
      (kbd "<tab>") #'mine/org-tab)))

(provide 'init-notes)
