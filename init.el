;; This is my Emacs configuration. There are many like it, but this one is mine.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/configs")

(let ((file-name-handler-alist nil)
      (gc-cons-threshold most-positive-fixnum))
	(require 'general)
	(require 'plugins)
	(require 'hotkeys)
	(require 'utility))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
