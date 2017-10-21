# Emacs.d
Lightweight Emacs configuration for web development

## Features

### Vim Emulation
The greatest Vim emulator there is, [Evil](https://github.com/emacs-evil/evil). Comes with [relative line numbers](https://github.com/coldnew/linum-relative) for the complete Vim experience.

### Git
Complete control for Git with [Magit](https://magit.vc/).
```SPC SPC magit-status``` -> ```c c``` -> ```C-c C-c``` 

### Clever code completion
* JavaScript using [Tern](http://ternjs.net/)
* PHP with [php-extras](https://marmalade-repo.org/packages/php-extras)

### Project management
[Projectile](https://github.com/bbatsov/projectile) brings clever project management to Emacs, allowing you to work with serveral different projects in your client. ```SPC p``` to get a complete list of commands. 

[Perspective](https://github.com/nex3/perspective-el) brings workspaces to Emacs, allowing you to work on serveral projects simultaneously without overlapping buffers.
Sprinkled with [persp-projectile](https://github.com/bbatsov/persp-projectile) to get that fluidity. 

### Emmet
You already know what it does. 

### Quick code navigation
```SPC s``` to trigger [swoop](https://github.com/ShingoFukuyama/emacs-swoop).

### Smex
```SPC SPC``` for an enhanced M-x interface.

### Which-key
Because sometimes you forget.

### Neotree
```SPC TAB``` to open a tree explorer. 

### Smart-Mode-Line
A smart mode line, it's simpler and less flashy than powerline.

### Multiple cursors
```grs``` to stop recording. ```grr``` to resume. 
```SPC m``` for options.

### Package repositories
Utilizes every major package repository.
```
(add-to-list 'package-archives '("melpa"     . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu"       . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org"       . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
```
