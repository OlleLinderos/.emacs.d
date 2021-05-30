(use-package platformio-mode
  :hook (c++-mode . platformio-mode))

;; TODO: Read platform type from platformio.ini,
;; based on that build a .ccls file with relevant header includes
;; (~/.platformio/packages/framework-arduinoespressif8266/cores/) etc
;; Also add header includes from .pio/libdeps/[env-name-from-platformio.ini]
;; Just add them all, and maybe force a clean before building .ccls file
(defun generate-platformio-ccls ()
  (interactive)
  (with-temp-buffer
    (insert-file-contents (expand-file-name "platformio.ini" projectile-project-root))
    (buffer-string)))

(provide 'init-platformio)
