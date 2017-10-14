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

### Projectile
Projectile brings clever project management to Emacs, allowing you to work with serveral different projects in your client. I wouldn't be able to use Emacs for my day job without this. 

Sprinkled with [persp-projectile](https://github.com/bbatsov/persp-projectile) on top to keep buffers from different projects separated.

### Emmet
You already know what it does. 

### Swoop
```SPC s``` to trigger [swoop](https://github.com/ShingoFukuyama/emacs-swoop).

### Smex
```SPC SPC``` for an enhanced M-x interface.

### Which-key
Because sometimes you forget.

### Neotree


### Packages

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

