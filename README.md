# Emacs.d
Lightweight Emacs configuration for web development

## Features

### Evil
The greatest Vim emulator there is. Using SPC as the leader.  

### Company
IDE-like code completion configured for
* JavaScript using [Tern](http://ternjs.net/)
* PHP with [php-extras](https://marmalade-repo.org/packages/php-extras)
* HTML & SCSS

### Emmet
You already know what it does. 

### Packages

* Which-key
* Smex
* Projectile
* Evil
* Neotree
* Swoop
* SML
* Company
* Php-mode
* Emmet
* Linum-relative

### Package repositories
Utilizes every major package repository.
```
(add-to-list 'package-archives '("melpa"     . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu"       . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org"       . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
```

### Syntax support
JavaScript (ES6), PHP, HTML, CSS/SCSS, Python, Ruby & Elisp

### Code completion
JavaScript, PHP, CSS/SCSS

For HTML there is Emmet. 

