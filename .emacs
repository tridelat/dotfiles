; hook to run file at the very end of this script
(add-hook 'after-init-hook '(lambda ()
                                (load "~/.emacs.d/my-noexternals.el")
                                ))

(load "~/.emacs.d/my-loadpackages.el")
(load "~/.emacs.d/my-evilconfig.el")

; syntax checking
(add-hook 'after-init-hook #'global-flycheck-mode)
; need to install: pip install pylint, in order to get python syntax check

; general programming options
(defun my-prog-options ()
  (linum-mode 1) ; line numbering
  (hs-minor-mode 1) ; code folding
  (show-paren-mode 1) ; highlight matching parenthesis
  (electric-pair-mode 1) ; inserts matching parenthesis
  )
(add-hook 'prog-mode-hook 'my-prog-options)
(setq-default indent-tabs-mode nil)
(add-hook 'LaTeX-mode-hook 'my-prog-options)

(require 'auto-complete)
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional



(load-theme 'zenburn t)
;(require 'color-theme-sanityinc-tomorrow)
;(color-theme-sanityinc-tomorrow--define-theme bright)

(require 'powerline)
(powerline-default-theme)
(display-time-mode t)

(require 'ido)
(ido-mode 1)
(setq ido-enable-flex-matching t)

;(require 'python)
;(setq python-shell-interpreter "ipython")
;(setq python-shell-interpreter-args "--pylab")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; I there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
