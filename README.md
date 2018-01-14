# Emacs.d
Lightweight Emacs configuration for web development, heavily inspired by Spacemacs

## Installation

Any recent Emacs version will work with this config, but I prefer using [d12frosted/homebrew-emacs-plus](https://github.com/d12frosted/homebrew-emacs-plus) because it gives you the option for some really cool features on installation. 
```
brew tap d12frosted/emacs-plus
brew install emacs-plus --without-spacemacs-icon --HEAD
```
To install this config run this
```
cd ~
git clone https://github.com/OlleLinderos/Emacs.d.git ~/.emacs.d
```

Then clone the Magit repository:
```
git clone https://github.com/magit/magit.git ~/.emacs.d/site-lisp/magit
cd ~/.emacs.d/site-lisp/magit
make
```

## Features

### Vim Emulation
The greatest Vim emulator there is, [Evil](https://github.com/emacs-evil/evil). Comes with [relative line numbers](https://github.com/coldnew/linum-relative).

### Git
Complete in-editor git control with [Magit](https://magit.vc/).

### Code completion
For JavaScript, Angular, Vue, CSS/SCSS, PHP, emmet for HTML.

### Project management
[Projectile](https://github.com/bbatsov/projectile) brings clever project management to Emacs, allowing you to work with serveral different projects in your client. ```SPC p``` to get a complete list of commands. 

### Quick code navigation
```SPC s``` to trigger [swiper](https://github.com/abo-abo/swiper) and ```SPC j``` for [avy](https://github.com/abo-abo/avy).

### Enhanced M-x interface
Counsel (using Ivy). ```SPC SPC``` for M-x.

### Multiple cursors
```grs``` to stop recording. ```grr``` to resume. 
```SPC m``` for options.
