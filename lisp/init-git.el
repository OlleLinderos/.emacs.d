;; -*- lexical-binding: t; -*-

(use-package magit
  :defer t
  :init
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1
        magit-blame-echo-style 'margin))

(defun boat/magit-visit-file-other-window-bindings ()
  (define-key magit-file-section-map (kbd "RET")
              #'magit-diff-visit-worktree-file-other-window)
  (define-key magit-hunk-section-map (kbd "RET")
              #'magit-diff-visit-worktree-file-other-window))
(with-eval-after-load 'magit-diff
  (add-hook 'magit-mode-hook #'boat/magit-visit-file-other-window-bindings))

(use-package diff-hl
  :init
  (setq diff-hl-side 'left
        diff-hl-show-hunk-inline-smart-lines nil)
  :config
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode 1)
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)
  (define-key evil-normal-state-map (kbd "C-g") #'diff-hl-show-hunk)) ;; primary bind

;;
;; My potentially crazy vibecoded code review workflow, proceed with caution.
;;
;; SPC g c -- boat/review-changes
;; SPC g r -- boat/review-branch
;;
;; Will open an imenu-list buffer to the left, containg either all uncommitted changes or all changes in this branch,
;; with a live previw buffer *review-changes* taking up the main window. RET will put you in a buffer of the actual file
;; you're reviwing at the line where you had your cursor.
;;
;; Editing and saving the file, and then opening this again, you will be in the same spot you left of from, with a diff including your new change.
;; The buffers are hidden when viewing projectile buffers, so it wont bloat your session.
;;
;; The boat/review-branch function has some baked in git blames, placed to the right and hightlighted in different colors depending on unstaged/staged/comitted.
;;
(use-package imenu-list
  :defer t
  :init
  (setq imenu-list-position 'left
        imenu-list-size 0.3
        imenu-list-auto-resize t
        imenu-list-focus-after-activation t)
  :config
  (when (fboundp 'catppuccin-color)
    (set-face-attribute 'imenu-list-entry-subalist-face-1 nil
                        :foreground (catppuccin-color 'red))
    (set-face-attribute 'imenu-list-entry-face-2 nil
                        :foreground (catppuccin-color 'text))
    (set-face-attribute 'boat/review-blame-committed nil
                        :background (catppuccin-color 'green) :foreground "white")
    (set-face-attribute 'boat/review-blame-staged nil
                        :background (catppuccin-color 'lavender) :foreground "white")))

(require 'cl-lib)
(require 'subr-x)
(require 'imenu)

(defvar boat/review-changes--active nil
  "Buffer-local flag marking an *Ilist* sidebar that previews review hunks.")

(defun boat/review-changes--imenu-index ()
  (let ((entries '()) (section "Changes") (file nil))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward
              "^\\(?:### \\(.+\\) ###\\|\\+\\+\\+ b/\\(.+\\)\\|@@ \\(-[0-9,]+ \\+[0-9,]+\\) @@\\(.*\\)\\)$"
              nil t)
        (cond
         ((match-string 1) (setq section (match-string-no-properties 1) file nil))
         ((match-string 2) (setq file (match-string-no-properties 2)))
         ((match-string 3)
          (push (list section (or file "?")
                      (replace-regexp-in-string
                       " +" " "
                       (string-trim (concat (match-string-no-properties 3) " "
                                            (match-string-no-properties 4))))
                      (line-beginning-position))
                entries)))))
    (let ((result '()))
      (dolist (e (nreverse entries))
        (cl-destructuring-bind (sec fl label pos) e
          (let* ((sc (or (assoc sec result)
                         (let ((c (list sec)))
                           (setq result (append result (list c))) c)))
                 (fc (or (assoc fl (cdr sc))
                         (let ((c (list fl)))
                           (setcdr sc (append (cdr sc) (list c))) c))))
            (setcdr fc (append (cdr fc) (list (cons label pos)))))))
      result)))

(defun boat/review-changes--preview ()
  (when boat/review-changes--active
    (let ((entry (imenu-list--find-entry)))
      (when (and entry (not (imenu--subalist-p entry)))
        (ignore-errors (imenu-list-display-entry))))))

(defvar boat/review--margin-width 32
  "Width of the right margin used for in-diff commit annotations.")

;; Dedicated faces so the blame highlight only applies in this review scenario.
(defface boat/review-blame-committed
  '((t :background "#a6e3a1" :foreground "white"))
  "Right-margin face for already-committed branch changes in *review-changes*.
Recolored from the catppuccin palette when available.")

(defface boat/review-blame-staged
  '((t :background "#b4befe" :foreground "white"))
  "Right-margin face for staged-but-uncommitted changes in *review-changes*.")

(defface boat/review-blame-unstaged
  '((t :inherit shadow))
  "Right-margin face for unstaged changes in *review-changes* (no background).")

(defun boat/review--unstaged-lines (file)
  (let ((set (make-hash-table :test 'eql)) (n nil))
    (with-temp-buffer
      (when (zerop (call-process "git" nil t nil "diff" "--" file))
        (goto-char (point-min))
        (while (not (eobp))
          (cond
           ((looking-at "^@@ -[0-9,]+ \\+\\([0-9]+\\)")
            (setq n (string-to-number (match-string 1))))
           ((and n (looking-at "^\\+\\+\\+")))            ; header, not a change
           ((and n (looking-at "^\\+")) (puthash n t set) (setq n (1+ n)))
           ((and n (looking-at "^ "))  (setq n (1+ n))))
          (forward-line 1))))
    set))

(defun boat/review--line-annotations (file)
  "Map working-tree line number -> propertized right-margin label for FILE.
Committed lines show hash+summary (green); staged-but-uncommitted lines show
`· staged' (lavender); unstaged lines show `· unstaged' (no background)."
  (let ((unstaged (boat/review--unstaged-lines file))
        (out      (make-hash-table :test 'eql)))
    (with-temp-buffer
      (when (zerop (call-process "git" nil t nil "blame" "--line-porcelain"
                                 "--" file))
        (goto-char (point-min))
        (let (sha summary lineno)
          (while (not (eobp))
            (cond
             ((looking-at "^\\([0-9a-f]\\{40\\}\\) [0-9]+ \\([0-9]+\\)")
              (setq sha (match-string 1)
                    lineno (string-to-number (match-string 2))
                    summary nil))
             ((looking-at "^summary \\(.*\\)")
              (setq summary (match-string-no-properties 1)))
             ((and lineno (looking-at "^\t"))
              (puthash lineno
                       (cond
                        ((not (string-match-p "\\`0+\\'" sha))
                         (propertize (format "%s %s" (substring sha 0 7)
                                             (or summary ""))
                                     'face 'boat/review-blame-committed))
                        ((gethash lineno unstaged)
                         (propertize "· unstaged"
                                     'face 'boat/review-blame-unstaged))
                        (t
                         (propertize "· staged"
                                     'face 'boat/review-blame-staged)))
                       out)
              (setq lineno nil)))
            (forward-line 1)))))
    out))

(defun boat/review--put-margin (pos text)
  "Show TEXT in the right margin on the screen line at POS via an overlay."
  (let ((ov  (make-overlay pos pos))
        (str (truncate-string-to-width text (1- boat/review--margin-width))))
    (overlay-put ov 'boat/review-margin t)
    ;; STR already carries its committed/uncommitted face from the blame map.
    (overlay-put ov 'before-string
                 (propertize " " 'display `((margin right-margin) ,str)))))

(defun boat/review--annotate-branch-commits ()
  "Annotate every added line in the current diff buffer with its commit.
Run in *review-changes* after `diff-mode' is on; uses overlays so the diff
text (and `diff-goto-source') is untouched."
  (setq-local right-margin-width boat/review--margin-width)
  (let ((blame (make-hash-table :test 'equal))
        (file nil) (newline-no nil))
    (save-excursion
      (goto-char (point-min))
      (while (not (eobp))
        (cond
         ((looking-at "^\\+\\+\\+ b/\\(.+\\)$")
          (setq file (match-string-no-properties 1) newline-no nil))
         ((looking-at "^@@ -[0-9,]+ \\+\\([0-9]+\\)")
          (setq newline-no (string-to-number (match-string 1))))
         ((and file newline-no (looking-at "^\\+"))
          (let* ((map  (or (gethash file blame)
                           (puthash file (boat/review--line-annotations file) blame)))
                 (info (gethash newline-no map)))
            (when info (boat/review--put-margin (line-beginning-position) info)))
          (setq newline-no (1+ newline-no)))
         ((and newline-no (looking-at "^ "))
          (setq newline-no (1+ newline-no))))
        (forward-line 1)))))

(defvar boat/review-changes--tearing-down nil
  "Reentrancy guard so the paired kill-buffer-hooks don't loop.")

(defvar boat/review--active-p nil
  "Non-nil while a review is fully shown, so the window watcher can tear it
down when the *Ilist* window is closed.")

(defvar boat/review--last-spot nil
  "Cons (FILE . HUNK-ORDINAL) last entered via RET, so reopening the review
returns to that exact hunk.  Cleared when the review is closed with `q' (or
killed), so a fresh open starts at the top.")

(defun boat/review--file-at-point ()
  "Return the b/ path of the diff hunk at point in *review-changes*, or nil."
  (save-excursion
    (when (re-search-backward "^\\+\\+\\+ b/\\(.+\\)$" nil t)
      (match-string-no-properties 1))))

(defun boat/review--hunk-ordinal-at-point ()
  "Return the 1-based index of the hunk at point within its file, or nil."
  (save-excursion
    (let ((p (point)) (n 0))
      (when (re-search-backward "^\\+\\+\\+ b/" nil t)
        (while (and (re-search-forward "^@@ " nil t)
                    (<= (match-beginning 0) p))
          (setq n (1+ n)))
        (and (> n 0) n)))))

(defun boat/review--spot-at-point ()
  "Return (FILE . HUNK-ORDINAL) for the diff position at point, or nil."
  (when-let* ((file (boat/review--file-at-point)))
    (cons file (boat/review--hunk-ordinal-at-point))))

(defun boat/review--goto-spot (spot)
  "In the current *Ilist* buffer, move point to SPOT = (FILE . HUNK-ORDINAL).
Lands on the FILE's HUNK-ORDINAL-th hunk, clamped to what the file now has.
Return non-nil if FILE's group was found."
  (goto-char (point-min))
  (let ((file (car spot)) (hunk (cdr spot)) found)
    (while (and (not found) (not (eobp)))
      (let ((e (imenu-list--find-entry)))
        (if (and e (imenu--subalist-p e) (equal (car e) file))
            (setq found t)
          (forward-line 1))))
    (when found
      (forward-line 1)                  ; first hunk leaf under the file
      (let ((i 1))
        (while (and hunk (> hunk i)
                    (save-excursion
                      (forward-line 1)
                      (let ((c (imenu-list--find-entry)))
                        (and c (not (imenu--subalist-p c))))))
          (forward-line 1)
          (setq i (1+ i)))
        (unless (let ((c (imenu-list--find-entry)))
                  (and c (not (imenu--subalist-p c))))
          (forward-line -1))))          ; file had no hunk leaf: stay on its line
    found))

(defun boat/review-changes--kill (&optional skip)
  "Kill review buffers *Ilist* and *review-changes* and their windows.
Buffer SKIP (if any) is not killed — used when Emacs is already killing it."
  (unless boat/review-changes--tearing-down
    (let ((boat/review-changes--tearing-down t))
      ;; A real close forgets the spot, so the next fresh open starts at top.
      (setq boat/review--last-spot nil
            boat/review--active-p nil)
      (dolist (name '("*Ilist*" "*review-changes*"))
        (when-let* ((b (get-buffer name)))
          (when-let* ((win (get-buffer-window b)))
            (ignore-errors (delete-window win)))
          (unless (eq b skip)
            (kill-buffer b)))))))

(defun boat/review-changes--teardown ()
  "Close the review UI: kill *Ilist* and *review-changes*.  Bound to `q'."
  (interactive)
  (boat/review-changes--kill))

(defun boat/review-changes--on-kill ()
  "`kill-buffer-hook': when one review buffer dies, take its partner with it."
  (boat/review-changes--kill (current-buffer)))

(defun boat/review--window-watch ()
  "Close the review when the *Ilist* window is closed (buffer left windowless).
Runs on `window-configuration-change-hook' while a review is active."
  (when (and boat/review--active-p
             (get-buffer "*Ilist*")
             (not (get-buffer-window "*Ilist*" t)))
    (boat/review-changes--teardown)))

(add-hook 'window-configuration-change-hook #'boat/review--window-watch)

(defun boat/review-changes-visit-source ()
  "Visit the real source file at the line under point, keeping the review open.
Remembers the file so re-running the review (`SPC g c' / `SPC g r') rebuilds
the diff with your new changes and returns to this file's spot.  Use `q' to
close the review.  Run from inside the *review-changes* diff buffer (RET)."
  (interactive)
  (setq boat/review--last-spot (boat/review--spot-at-point))
  ;; Open the file in *this* window (replacing the diff) instead of splitting.
  (let ((display-buffer-overriding-action '((display-buffer-same-window))))
    (diff-goto-source)))

(defun boat/review--ref-exists-p (ref)
  "Return non-nil if REF resolves to a commit in the current repo."
  (zerop (call-process "git" nil nil nil "rev-parse" "--verify" "--quiet"
                       (concat ref "^{commit}"))))

(defun boat/review--branch-base ()
  "Return (BASE-NAME . MERGE-BASE-SHA) for HEAD vs the repo's base branch.
The base branch is the first of main/master/develop/trunk that exists.
Returns nil if none is found."
  (when-let* ((base (seq-find #'boat/review--ref-exists-p
                              '("main" "master" "develop" "trunk"))))
    (with-temp-buffer
      (when (zerop (call-process "git" nil t nil "merge-base" base "HEAD"))
        (cons base (string-trim (buffer-string)))))))

(defun boat/review--populate-working ()
  "Insert staged + unstaged diff sections into the current buffer."
  (insert "### Staged ###\n\n")
  (call-process "git" nil t nil "diff" "--cached")
  (goto-char (point-max))
  (insert "\n### Unstaged ###\n\n")
  (call-process "git" nil t nil "diff"))

(defun boat/review--populate-branch ()
  "Insert every change exclusive to the current branch (commits + worktree).
Diffs from the merge-base with the base branch to the working tree, so old
commits on the branch and uncommitted changes are all included."
  (let ((base (boat/review--branch-base)))
    (if (not base)
        (insert "### No base branch (main/master/develop/trunk) found ###\n")
      (insert (format "### Branch changes vs %s ###\n\n" (car base)))
      (call-process "git" nil t nil "diff" (cdr base)))))

(defun boat/review--show (populate-fn &optional annotate-fn)
  "Build *review-changes* via POPULATE-FN and open the live-preview sidebar.
ANNOTATE-FN, if given, runs in the diff buffer after `diff-mode' to decorate
it (e.g. branch-commit margins).  Any existing review is closed first so the
diff always reflects the latest changes.  The diff fills the current window at
full height; *Ilist* is a full-height side window.  Moving point in *Ilist*
previews the hunk in the main window."
  (require 'imenu-list)
  ;; Close any open review and rebuild from scratch (latest changes), but keep
  ;; the spot last entered via RET so we can return to it below.
  (let ((last-spot boat/review--last-spot))
    (boat/review-changes--kill)
    (setq boat/review--last-spot last-spot))
  (let* ((root (or (vc-root-dir) default-directory))
         (default-directory root)
         (buf (get-buffer-create "*review-changes*")))
    ;; Flush unsaved edits in this repo to disk so `git diff' sees the latest.
    (save-some-buffers
     t (lambda () (and buffer-file-name
                       (string-prefix-p (expand-file-name root)
                                        (expand-file-name buffer-file-name)))))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (funcall populate-fn))
      (goto-char (point-min))
      (diff-mode)
      ;; Resolve a/ and b/ paths against the repo root so RET (diff-goto-source)
      ;; can find the real files.
      (setq-local default-directory root)
      (setq-local imenu-create-index-function #'boat/review-changes--imenu-index)
      (when annotate-fn (funcall annotate-fn))
      (setq buffer-read-only t)
      ;; RET visits the real file at point and closes the review; q just
      ;; closes.  Use a buffer-local map (inheriting diff-mode-map) so we
      ;; don't leak these bindings into every diff buffer.
      (use-local-map (let ((map (make-sparse-keymap)))
                       (set-keymap-parent map diff-mode-map)
                       (define-key map (kbd "RET") #'boat/review-changes-visit-source)
                       (define-key map (kbd "q") #'boat/review-changes--teardown)
                       map))
      (when (fboundp 'evil-local-set-key)
        (dolist (state '(normal motion))
          (evil-local-set-key state (kbd "RET") #'boat/review-changes-visit-source)
          (evil-local-set-key state (kbd "q") #'boat/review-changes--teardown)))
      ;; Killing this buffer by any means also closes the sidebar.
      (add-hook 'kill-buffer-hook #'boat/review-changes--on-kill nil t))
    ;; Full-height preview: give the diff the whole current window, then let
    ;; imenu-list split a full-height side window off the frame root for
    ;; *Ilist*.  Driving the update by hand (not the minor-mode timer) keeps
    ;; our static index from being clobbered when focus leaves the diff buffer.
    (delete-other-windows)
    (switch-to-buffer buf)
    (imenu-list-update t)
    (imenu-list-show)
    (with-current-buffer "*Ilist*"
      ;; Return to the spot last entered via RET (now showing fresh changes);
      ;; otherwise start at the top.
      (goto-char (point-min))
      (when boat/review--last-spot
        (boat/review--goto-spot boat/review--last-spot))
      (setq-local boat/review-changes--active t)
      (add-hook 'post-command-hook #'boat/review-changes--preview nil t)
      (add-hook 'kill-buffer-hook #'boat/review-changes--on-kill nil t))
    (when-let* ((win (get-buffer-window "*Ilist*")))
      (select-window win)
      (set-window-point win (with-current-buffer "*Ilist*" (point))))
    ;; Now that the layout is settled, arm the window watcher.
    (setq boat/review--active-p t)))

(defun boat/review-changes ()
  "Review staged + unstaged changes via a live-preview imenu-list sidebar."
  (interactive)
  (boat/review--show #'boat/review--populate-working))

(defun boat/review-branch ()
  "Review everything exclusive to the current branch (old commits + worktree).
Each added line in the diff is annotated, in the right margin, with the branch
commit that introduced it."
  (interactive)
  (boat/review--show #'boat/review--populate-branch
                     #'boat/review--annotate-branch-commits))

(provide 'init-git)
