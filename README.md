# Emacs.d
Lightweight Emacs configuration for web development

## Installation

Any recent Emacs version will work with this config, but I prefer using [d12frosted/homebrew-emacs-plus](https://github.com/d12frosted/homebrew-emacs-plus) because it gives you the option for some really cool features on installation. 

Get homebrew first, if you haven't already.
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
I really like running --with-natural-title-bar, full list of options [here](https://github.com/d12frosted/homebrew-emacs-plus#options).
```
brew tap d12frosted/emacs-plus
brew install emacs-plus --without-spacemacs-icon --with-natural-title-bar --HEAD
```
If you have a pre-existing emacs config, back it up with
```
$ mv ~/.emacs ~/.emacs_backup & mv ~/.emacs.d ~/.emacs.d_backup
```
To install this config run this in your home directory
```
$ git clone https://github.com/OlleLinderos/Emacs.d.git ~/.emacs.d
```

Then clone the Magit repository:
```
$ git clone https://github.com/magit/magit.git ~/.emacs.d/site-lisp/magit
$ cd ~/.emacs.d/site-lisp/magit
```
Then compile the libraries and generate the info manuals:
```
$ make
```

## Features

### Vim Emulation
The greatest Vim emulator there is, [Evil](https://github.com/emacs-evil/evil). Comes with [relative line numbers](https://github.com/coldnew/linum-relative).

### Git
Complete in-editor git control with [Magit](https://magit.vc/).

Has to be downloaded via Git right now, https://magit.vc/manual/magit/Installing-from-the-Git-Repository.html#Installing-from-the-Git-Repository because magit-popout- is missing from elpa.

### Clever code completion
For JavaScript, CSS/SCSS, PHP, emmet for HTML.

### Project management
[Projectile](https://github.com/bbatsov/projectile) brings clever project management to Emacs, allowing you to work with serveral different projects in your client. ```SPC p``` to get a complete list of commands. 

[Perspective](https://github.com/nex3/perspective-el) allows you to work on serveral projects simultaneously without overlapping buffers.
Sprinkled with [persp-projectile](https://github.com/bbatsov/persp-projectile) for fluidity. 

```SPC TAB``` to open [Neotree](https://github.com/jaypei/emacs-neotree).

### Quick code navigation
```SPC s``` to trigger [swiper](https://github.com/abo-abo/swiper) and ```SPC j``` for [avy](https://github.com/abo-abo/avy).

### Enhanced M-x interface
Recently replace Smex (using Ido) with Counsel (using Ivy). ```SPC SPC``` for M-x.

### Which-key
Press any prefix key to get a complete tooltip with hotkey suggestions. ```SPC``` is the leader key in this config. 

### Multiple cursors
```grs``` to stop recording. ```grr``` to resume. 
```SPC m``` for options.

## Todo
* Vue-mode
