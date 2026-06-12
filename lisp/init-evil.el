;; -*- lexical-binding: t; -*-

(setq evil-want-keybinding nil
      evil-want-integration t
      evil-want-C-u-scroll t
      evil-undo-system 'undo-fu)

(use-package evil
  :init
  (evil-mode 1)
  :config
  (setq-default evil-kill-on-visual-paste nil)
  (global-set-key [escape] 'minibuffer-keyboard-quit)
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)

  ;; Not sure if this is needed with cofu, but it interfered with company so had to nil it
  (define-key evil-insert-state-map (kbd "C-p") nil)
  (define-key evil-insert-state-map (kbd "C-n") nil)
  (define-key evil-insert-state-map (kbd "C-u")
              (lambda ()
                (interactive)
                (evil-delete (line-beginning-position) (point)))))

;; Vim bindings in magit, dired, ibuffer, treemacs, etc.
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Probably never using this so lets toss it?
(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

;; Comment entire visual blocks with gc
(use-package evil-nerd-commenter
  :after evil
  :config
  (evil-define-key '(normal visual) 'global "gc" 'evilnc-comment-operator))

(use-package avy
  :after evil
  :config
  (evil-define-key '(normal visual motion) 'global (kbd "gss") 'evil-avy-goto-char-2))

;; My own leader-map takes priority over evil
(defvar boat/leader-map (make-sparse-keymap))
(evil-define-key '(normal visual motion) 'global (kbd "SPC") boat/leader-map)

(defun boat/evil-delete-advice (orig-fn beg end &optional type _ &rest args)
  "Send deleted text to the black-hole register."
  (apply orig-fn beg end type ?_ args))
(advice-add 'evil-delete-char :around #'boat/evil-delete-advice) ;; vim x deletion should not put into clipboard

(defvar boat/window-nav-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-h") #'evil-window-left)
    (define-key map (kbd "C-j") #'evil-window-down)
    (define-key map (kbd "C-l") #'evil-window-right)
    map))
(define-key boat/window-nav-mode-map (kbd "C-k")
            '(menu-item "" evil-window-up
                        :filter (lambda (cmd) (unless (minibufferp) cmd))))

;; C-c -> recenter everywhere EXCEPT magit and commit-message buffers,
;; which rely on C-c as a prefix, and vterm, where C-c must reach the shell as SIGINT.
(define-key boat/window-nav-mode-map (kbd "C-c")
            '(menu-item "" recenter-top-bottom
                        :filter (lambda (cmd)
                                  (unless (or (derived-mode-p 'magit-mode 'vterm-mode)
                                              (bound-and-true-p git-commit-mode))
                                    cmd))))

(define-minor-mode boat/window-nav-mode
  "Global minor mode binding C-hjkl to window navigation and C-c to recenter."
  :global t
  :init-value t
  :keymap boat/window-nav-mode-map)
(boat/window-nav-mode 1)
(add-to-list 'emulation-mode-map-alists
             `((boat/window-nav-mode . ,boat/window-nav-mode-map)))

(provide 'init-evil)
