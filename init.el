(package-initialize)
(add-to-list 'load-path "~/.emacs.d/configs")

(let ((file-name-handler-alist nil)
      (gc-cons-threshold most-positive-fixnum))

  ;; General setup
  (require 'packages)
  (require 'general)
  (require 'theme)
  (require 'editor)
  (require 'workflow)
  (require 'utility)

  ;; Language setup
  (require 'init-cpp)
  (require 'init-python)
  (require 'init-clojure)
  (require 'init-ruby)
  (require 'init-haskell)
  (require 'init-elm)
  (require 'init-web)

  ;; !important
  (require 'hotkeys))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
