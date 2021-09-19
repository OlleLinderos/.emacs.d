(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/custom-packages")

(defvar best-gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(let ((file-name-handler-alist nil)
      (gc-cons-threshold most-positive-fixnum))
  (require 'init-packages)
  (require 'init-defaults)
  (require 'init-theme)
  (require 'init-editor)
  (require 'init-workflow)
  (require 'init-hotkeys)
  (require 'init-utility)

  (require 'init-docs)
  (require 'init-lsp)
  (require 'init-c-cpp)
  (require 'init-platformio)
  (require 'init-go)
  (require 'init-term)
  (require 'init-python)
  (require 'init-clojure)
  (require 'init-ruby)
  (require 'init-haskell)
  (require 'init-web)
  (require 'init-nim)
  (require 'init-elixir))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(setq gc-cons-threshold best-gc-cons-threshold)
