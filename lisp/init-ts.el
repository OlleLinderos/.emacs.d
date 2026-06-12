;;; -*- lexical-binding: t; -*-

(setq treesit-language-source-alist
      '((typescript "https://github.com/tree-sitter/tree-sitter-typescript"
                    "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript"
             "master" "tsx/src")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript")
        (jsdoc "https://github.com/tree-sitter/tree-sitter-jsdoc")
        (go "https://github.com/tree-sitter/tree-sitter-go")
        (gomod "https://github.com/camdencheek/tree-sitter-go-mod")))

(defun mine/treesit-install-grammars ()
  (interactive)
  (dolist (lang (mapcar #'car treesit-language-source-alist))
    (unless (treesit-language-available-p lang)
      (treesit-install-language-grammar lang))))

(when (and (treesit-available-p)
           (treesit-language-available-p 'typescript)
           (treesit-language-available-p 'tsx))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.cts\\'" . typescript-ts-mode))
  (when (treesit-language-available-p 'javascript)
    (add-to-list 'major-mode-remap-alist '(js-mode . js-ts-mode)))

  (dolist (hook '(tsx-ts-mode-hook typescript-ts-mode-hook js-ts-mode-hook))
    (add-hook hook #'lsp-deferred)))

(defun mine/ts-extra-fontify ()
  (unless (bound-and-true-p mine--ts-extra-fontify-done)
    (setq-local mine--ts-extra-fontify-done t)
    (let ((lang (if (derived-mode-p 'tsx-ts-mode) 'tsx 'typescript)))
      (setq-local treesit-font-lock-settings
                  (append treesit-font-lock-settings
                          (treesit-font-lock-rules
                           :language lang :feature 'mine-member-prop :override t
                           '((member_expression
                              property: (property_identifier)
                              @font-lock-property-use-face))))))
    (treesit-font-lock-recompute-features '(function mine-member-prop))
    (font-lock-flush)))
(dolist (hook '(typescript-ts-mode-hook tsx-ts-mode-hook))
  (add-hook hook #'mine/ts-extra-fontify))

(with-eval-after-load 'typescript-ts-mode
  (when (facep 'typescript-ts-jsx-attribute-face)
    (set-face-attribute 'typescript-ts-jsx-attribute-face nil
                        :foreground "#dc8a78")))

(use-package prettier-js
  :commands (prettier-js prettier-js-mode))

(provide 'init-ts)
