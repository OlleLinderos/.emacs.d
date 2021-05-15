(require 'package)

(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa"        . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu"          . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org"          . "http://orgmode.org/elpa/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t
      use-package-always-defer t)

(use-package use-package-ensure-system-package)

(provide 'init-packages)
