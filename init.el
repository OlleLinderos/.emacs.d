(package-initialize)

(add-to-list 'load-path "~/.emacs.d/configs")

(let ((file-name-handler-alist nil)
      (gc-cons-threshold most-positive-fixnum))

  ;; General setup
  (require 'packages)
  (require 'general)
  (require 'theme)
  (require 'utility)
  (require 'hotkeys)
  (require 'editor)
  (require 'workflow)

  ;; Language setup
  (require 'init-python)
  (require 'init-clojure)
  (require 'init-ruby)
  (require 'init-haskell)
  (require 'init-javascript)
  (require 'init-web))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
