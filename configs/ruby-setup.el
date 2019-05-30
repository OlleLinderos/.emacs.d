(use-package robe
  :init
  (add-hook 'ruby-mode-hook 'enh-ruby-mode))

(eval-after-load 'company
  '(push 'company-robe company-backends))

(provide 'ruby-setup)
