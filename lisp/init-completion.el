;; -*- lexical-binding: t; -*-

(use-package vertico
  :init
  (setq vertico-cycle t
        enable-recursive-minibuffers t)
  (vertico-mode 1)
  :config
  ;; Home-row candidate navigation, carried over from the old ivy map.
  (define-key vertico-map (kbd "C-q") #'vertico-previous)
  (define-key vertico-map (kbd "C-w") #'vertico-next)
  (define-key vertico-map (kbd "C-e") #'vertico-exit)
  ;; C-k kills the buffer under point and keeps completing, matching the
  ;; old ivy-switch-buffer-kill.
  (define-key vertico-map (kbd "C-k") #'boat/vertico-kill-buffer-candidate))

(defun boat/vertico-kill-buffer-candidate ()
  "Kill the buffer named by the current candidate, then refresh the list."
  (interactive)
  (let ((cand (vertico--candidate)))
    (when (and cand (get-buffer cand))
      (kill-buffer cand)
      (vertico--exhibit))))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion))))
  :config
  (dolist (face '(orderless-match-face-0 orderless-match-face-1
                  orderless-match-face-2 orderless-match-face-3))
    (when (facep face)
      (set-face-attribute face nil
                          :background (face-background 'region nil t)
                          :foreground 'unspecified
                          :weight 'normal))))

(use-package marginalia
  :init
  (marginalia-mode 1))

(use-package consult
  :defer t
  :init
  (setq consult-project-function
        (lambda (_) (and (fboundp 'projectile-project-root)
                         (projectile-project-root)))))

(use-package embark
  :defer t
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult))

(provide 'init-completion)
