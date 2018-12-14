;; This is my Emacs configuration. There are many like it, but this one is mine.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/configs")

(let ((file-name-handler-alist nil)
      (gc-cons-threshold most-positive-fixnum))
  (require 'packages)     ;; setup packages
  (require 'general)      ;; my own defaults
  (require 'theme)        ;; theming settings
  (require 'editor)       ;; inside prog buffer
  (require 'ide)          ;; ide tools
  (require 'python-setup) ;; python
  (require 'clojure)      ;; everything clojure
  (require 'web)          ;; webmode (html, css, inline js)
  (require 'tsjs)         ;; typescript & javascript
  (require 'hotkeys)      ;; hotkeys
  (require 'utility)      ;; custom utility functions
  )

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
