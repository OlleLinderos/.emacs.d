;;; -*- lexical-binding: t; -*-

;; Must be set before evil loads (evil-collection requirement).
(setq evil-want-keybinding nil
      evil-want-integration t
      evil-want-C-u-scroll t
      evil-undo-system 'undo-fu)

(use-package undo-fu)
(use-package undo-fu-session
  :config
  (undo-fu-session-global-mode 1))

(use-package evil
  :init
  (evil-mode 1)
  :config
  (setq-default evil-kill-on-visual-paste nil)
  (global-set-key [escape] 'minibuffer-keyboard-quit)
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
  ;; Don't let evil's completion shadow company in insert state.
  (define-key evil-insert-state-map (kbd "C-p") nil)
  (define-key evil-insert-state-map (kbd "C-n") nil)
  (define-key evil-insert-state-map (kbd "C-u")
              (lambda ()
                (interactive)
                (evil-delete (line-beginning-position) (point)))))

;; `:x' should save and kill the buffer, not close the window / quit Emacs
(defun mine/save-and-kill-buffer ()
  "Save the buffer if modified, then kill it."
  (interactive)
  (when (buffer-modified-p)
    (save-buffer))
  (kill-current-buffer))
(with-eval-after-load 'evil
  (evil-ex-define-cmd "x[it]" #'mine/save-and-kill-buffer))

;; Vim bindings in magit, dired, ibuffer, etc.
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

;; `g c` to comment line/region
(use-package evil-nerd-commenter
  :after evil
  :config
  (evil-define-key '(normal visual) 'global "gc" 'evilnc-comment-operator))

;; `g s s' to jump anywhere
(use-package avy
  :after evil
  :config
  (evil-define-key '(normal visual motion) 'global (kbd "gss") 'avy-goto-char-timer))

(defvar mine/leader-map (make-sparse-keymap))
(evil-define-key '(normal visual motion) 'global (kbd "SPC") mine/leader-map)

;; c / x don't clobber the clipboard
(defun mine/evil-delete-advice (orig-fn beg end &optional type _ &rest args)
  "Send deleted text to the black-hole register."
  (apply orig-fn beg end type ?_ args))
;; (advice-add 'evil-delete :around #'mine/evil-delete-advice)
(advice-add 'evil-delete-char :around #'mine/evil-delete-advice)
(advice-add 'evil-change :around #'mine/evil-delete-advice)

;; C-h/j/k/l window navigation _everywhere_
(defvar mine/window-nav-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-h") #'evil-window-left)
    (define-key map (kbd "C-j") #'evil-window-down)
    (define-key map (kbd "C-l") #'evil-window-right)
    map)
  "Keymap for global C-hjkl window navigation and C-c recenter.")

(define-key mine/window-nav-mode-map (kbd "C-k")
            '(menu-item "" evil-window-up
                        :filter (lambda (cmd) (unless (minibufferp) cmd))))

;; C-c to recenter everywhere except magit and commit-message buffers.
(define-key mine/window-nav-mode-map (kbd "C-c")
            '(menu-item "" recenter-top-bottom
                        :filter (lambda (cmd)
                                  (unless (or (derived-mode-p 'magit-mode)
                                              (bound-and-true-p git-commit-mode))
                                    cmd))))

(define-minor-mode mine/window-nav-mode
  "Global minor mode binding C-hjkl to window navigation and C-c to recenter."
  :global t
  :init-value t
  :keymap mine/window-nav-mode-map)
(mine/window-nav-mode 1)
(add-to-list 'emulation-mode-map-alists
             `((mine/window-nav-mode . ,mine/window-nav-mode-map)))

(provide 'init-evil)
