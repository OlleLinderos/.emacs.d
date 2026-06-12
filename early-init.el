;; -*- lexical-biding: t -*-

;; Max out GC during startup, once done normalize it.
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 100000000
                  gc-cons-percentage 0.1)))

;; I do my package setup in lisp/init-packages.el
(setq package-enable-at-startup nil)

;; Hide irrelevant warnings from appearing in their own buffers
(setq native-comp-async-report-warnings-errors 'silent)

;; Turn my GUI into a TUI
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)
(push '(horizontal-scroll-bars . nil) default-frame-alist)
(push '(fullscreen . maximized) default-frame-alist)
(setq frame-inhibit-implied-resize t)

(setq inhibit-startup-screen t)
