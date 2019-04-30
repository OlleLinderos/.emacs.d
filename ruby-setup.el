(use-package robe
  :config
  (global-robe-mode))

(eval-after-load 'company
  '(push 'company-robe company-backends))

(provide 'ruby-setup)
