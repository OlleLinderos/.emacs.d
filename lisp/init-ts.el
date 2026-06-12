;; -*- lexical-binding: t; -*-

(use-package prettier-js
  :commands (prettier-js prettier-js-mode))

;; TS/TSX syntax highlighting is not great.
;; Adding color to methods and properties, as those had no differentiator before.
(defun boat/ts-extra-fontify ()
  (unless (bound-and-true-p boat--ts-extra-fontify-done)
    (setq-local boat--ts-extra-fontify-done t)
    (let ((lang (if (derived-mode-p 'tsx-ts-mode) 'tsx 'typescript)))
      (setq-local treesit-font-lock-settings
                  (append treesit-font-lock-settings
                          (treesit-font-lock-rules
                           :language lang :feature 'boat-member-prop :override t
                           '((member_expression
                              property: (property_identifier)
                              @font-lock-property-use-face))))))
    (treesit-font-lock-recompute-features '(function boat-member-prop))
    (font-lock-flush)))
(dolist (hook '(typescript-ts-mode-hook tsx-ts-mode-hook))
  (add-hook hook #'boat/ts-extra-fontify))

(with-eval-after-load 'typescript-ts-mode
  (when (facep 'typescript-ts-jsx-attribute-face)
    (set-face-attribute 'typescript-ts-jsx-attribute-face nil
                        :foreground "#dc8a78")))

(provide 'init-ts)
