(use-package web-mode
  :ensure-system-package ((typescript-language-server . "npm i -g typescript-language-server")
                          (tsserver . "npm i -g typescript"))
  :mode (("\\.js\\'" . web-mode)
	 ("\\.jsx\\'" . web-mode)
	 ("\\.ts\\'" . web-mode)
	 ("\\.tsx\\'" . web-mode)
	 ("\\.html\\'" . web-mode)
	 ("\\.vue\\'" . web-mode)
	 ("\\.json\\'" . web-mode)
         ("\\.tpl\\.php\\'" . web-mode))
  :commands web-mode
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-indent-style 2
        web-mode-block-padding 2
        web-mode-comment-style 2
        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        web-mode-enable-part-face t
        lsp-enable-indentation nil)
  :hook (web-mode . lsp-deferred))

(setq lsp-clients-typescript-tls-path "~/.nvm/versions/node/v14.8.0/bin/typescript-language-server")

;; TODO: Can this be done in an :after above?
(eval-after-load 'web-mode
    '(progn
       (add-hook 'web-mode-hook #'add-node-modules-path)
       (add-hook 'web-mode-hook #'prettier-js-mode)))

(use-package add-node-modules-path)
(require' prettier-js)
(define-key text-map (kbd "p") 'prettier-js)

;; (require 'dap-chrome)

;; (with-eval-after-load "dap-mode"
;;   (dap-register-debug-template
;;    "Chromium Browse URL :: mainframe"
;;    (list :type "Chrome"
;;          :cwd nil
;;          :mode "url"
;;          :runtimeExecutable "/usr/bin/chromium-browser"
;;          :request "launch"
;;          :url "http://localhost:8101"
;;          :name "Chromium Browse URL")))

(provide 'init-web)
