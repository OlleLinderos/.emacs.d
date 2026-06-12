;;; -*- lexical-binding: t; -*-

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setq read-process-output-max (* 1024 1024))

(let ((file-name-handler-alist nil))
  (require 'init-packages)
  (require 'init-defaults)
  (require 'init-evil)
  (require 'init-theme)
  (require 'init-modeline)
  (require 'init-editor)
  (require 'init-workflow)
  (require 'init-git)
  (require 'init-completion)
  (require 'init-term)
  (require 'init-claude)
  (require 'init-hotkeys)
  (require 'init-utility)

  (require 'init-treesitter)
  (require 'init-lsp)
  (require 'init-ts)
  (require 'init-go)
  (require 'init-web)
  (require 'init-sql))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)
