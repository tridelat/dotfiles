; hook to run file at the very end of this script
(add-hook 'after-init-hook '(lambda ()
                                (load "~/.emacs.d/my-noexternals.el")
                                ))

(load "~/.emacs.d/my-loadpackages.el")
(load "~/.emacs.d/my-evilconfig.el")

; syntax checking
(add-hook 'after-init-hook #'global-flycheck-mode)
; need to install: pip install pylint, in order to get python syntax check

;; options for fill-column highlighting
(setq-default fill-column 79)
(require 'column-marker)
(set-face-background 'column-marker-1 "red")

(setq-default indent-tabs-mode nil)
(global-linum-mode 1) ; line numbering
(show-paren-mode 1) ; highlight matching parenthesis
(electric-pair-mode 1) ; inserts matching parenthesis
; general programming options
(defun my-prog-options ()
  (hs-minor-mode 1) ; code folding
  (column-marker-1 fill-column) ; highlights fill-column
  )
(defun my-latex-options ()
  (outline-minor-mode 1) ; to fold sections
  (TeX-fold-mode 1) ; characters and references folded
  (add-hook 'find-file-hook 'TeX-fold-buffer t) ; TeX-fold-buffer automatically
  ;; automatically not caching for LaTeX preview (problems with subfiles otherwise)
  (setq preview-auto-cache-preamble nil)
  )
(add-hook 'prog-mode-hook 'my-prog-options)
(add-hook 'LaTeX-mode-hook 'my-latex-options)
(add-hook 'latex-mode-hook 'my-latex-options)

(require 'auto-complete)
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional

(load-theme 'molokai t)
;(require 'color-theme-sanityinc-tomorrow)
;(color-theme-sanityinc-tomorrow--define-theme bright)


;; need org-mode 8.0+ for the following
(eval-after-load "org"
  '(require 'ox-md nil t))
(require 'ox-gfm nil t)

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
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "2e5705ad7ee6cfd6ab5ce81e711c526ac22abed90b852ffaf0b316aa7864b11f" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "08851585c86abcf44bb1232bced2ae13bc9f6323aeda71adfa3791d6e7fea2b6" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
