;;
;; Clojure
;;
(use-package cider)
(require 'cider)

(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")
(setq cider-auto-select-error-buffer nil)

(add-hook 'cider-mode-hook
   '(lambda () (add-hook 'after-save-hook
    '(lambda ()
       (if (and (boundp 'cider-mode) cider-mode)
    (cider-load-buffer))))))


(provide 'clojure)
