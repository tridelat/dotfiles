; hook to run file at the very end of this script
(add-hook 'after-init-hook '(lambda ()
                                (load "~/.emacs.d/my-noexternals.el")
                                ))

(load "~/.emacs.d/my-loadpackages.el")

(evil-mode 1) 

(load-theme 'monokai t)

(require 'powerline)
;(powerline-evil-vim-color-theme)
(display-time-mode t)

(require 'evil)
(evil-mode 1) 
;change cursor color depending on mode works only in GUI!!
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
