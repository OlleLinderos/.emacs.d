
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/configs")
(add-to-list 'load-path "~/.emacs.d/custom-packages")

(defvar best-gc-cons-threshold 4000000)

(let ((file-name-handler-alist nil)
      (gc-cons-threshold most-positive-fixnum))
  (require 'packages)
  (require 'general)
  (require 'theme)
  (require 'editor)
  (require 'workflow)
  (require 'utility)

  ;(require 'init-cpp)
  (require 'init-go)
  (require 'init-term)
  (require 'init-python)
  (require 'init-clojure)
  (require 'init-ruby)
  (require 'init-haskell)
  (require 'init-web)

  (require 'hotkeys))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(setq gc-cons-threshold best-gc-cons-threshold)
