(use-package cider
  :pin melpa-stable
  :config
  (setq cider-default-cljs-repl
        "(cond
  (and (resolve 'user/run) (resolve 'user/browser-repl)) ;; Chestnut projects
  (eval '(do (user/run)
             (user/browser-repl)))

  (try
    (require 'figwheel-sidecar.repl-api)
    (resolve 'figwheel-sidecar.repl-api/start-figwheel!)
    (catch Throwable _))
  (eval '(do (figwheel-sidecar.repl-api/start-figwheel!)
             (figwheel-sidecar.repl-api/cljs-repl)))

  (try
    (require 'cemerick.piggieback)
    (resolve 'cemerick.piggieback/cljs-repl)
    (catch Throwable _))
  (eval '(cemerick.piggieback/cljs-repl (cljs.repl.rhino/repl-env)))

  :else
  (throw (ex-info \"Failed to initialize CLJS repl. Add com.cemerick/piggieback and optionally figwheel-sidecar to your project.\" {})))")
  (add-hook 'cider-mode-hook
            '(lambda () (add-hook 'after-save-hook
                                  '(lambda ()
                                     (if (and (boundp 'cider-mode) cider-mode)
                                         (cider-load-buffer)))))))
(use-package clj-refactor)

;;-- Hotkeys 
(progn
  (define-prefix-command 'cider-map)
  (define-key cider-map (kbd "e") 'cider-eval-defun-at-point)
  (define-key cider-map (kbd "j") 'jackin-map))

(progn
  (define-prefix-command 'jackin-map)
  (define-key jackin-map (kbd "s") 'cider-jack-in-clojurescript)
  (define-key jackin-map (kbd "c") 'cider-jack-in-clojure))

(provide 'init-clojure)
