(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :ensure t
  :config
    (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
    (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
    (define-key copilot-completion-map (kbd "M-p") 'copilot-previous-completion)
    (define-key copilot-completion-map (kbd "M-n") 'copilot-next-completion)
    (define-key copilot-completion-map (kbd "M-<tab>") 'copilot-accept-completion-by-word))

(add-hook 'prog-mode-hook 'copilot-mode)

(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))

(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter
  :config (tree-sitter-require 'tsx)
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-mode . tsx)))

(setq-default tab-width 4)

(use-package evil
  :init (evil-mode 1)
  :config
  (global-set-key [escape] 'minibuffer-keyboard-quit)
  (setq evil-want-C-u-scroll t)
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-insert-state-map (kbd "C-p") nil) ;; dabbrev-expand messing with company-capf
  (define-key evil-insert-state-map (kbd "C-n") nil) ;; 
  (define-key evil-insert-state-map (kbd "C-u")
    (lambda ()
      (interactive)
      (evil-delete (point-at-bol) (point)))))

(setq-default evil-kill-on-visual-paste nil)

(use-package evil-leader
  :demand
  :config
  (progn
    (setq evil-leader/in-all-states t)
    (global-evil-leader-mode))
  (evil-leader/set-leader "SPC")
  (evil-leader/set-key
    "/" 'comment-or-uncomment-region
    "," 'evil-avy-goto-char
    "b" 'buffer-map
    "m" 'text-map
    "e" 'eval-buffer
    "f" 'file-map
    "w" 'evil-window-map
    "a" 'vc-annotate))

(use-package evil-mc
  :init
  (evil-mc-mode 1))

(use-package company
  :config
  (setq company-tooltip-align-annotations t
        company-idle-delay t
        company-tooltip-limit 20
        company-tooltip-align-annotations t
        company-begin-commands '(self-insert-command))
  :hook ((after-init . global-company-mode)))

(use-package company-quickhelp
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip))

(use-package flycheck)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(setq show-paren-delay 0)
(show-paren-mode 1)
(electric-pair-mode t)

(setq linum-format " %d")
(add-hook 'prog-mode-hook 'linum-mode)

(require 'git-gutter-fringe)
(setq-default right-fringe-width 20)
(setq git-gutter-fr:side 'right-fringe)

(use-package hl-todo
  :init
  (global-hl-todo-mode t)
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(provide 'init-editor)
