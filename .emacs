; hook to run file at the very end of this script
(add-hook 'after-init-hook '(lambda ()
                                (load "~/.emacs.d/my-noexternals.el")
                                ))

(load "~/.emacs.d/my-loadpackages.el")

(evil-mode 1) 

;(load-theme 'zenburn t)
(require 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow--define-theme bright)

(require 'powerline)
;(powerline-evil-vim-color-theme)
(powerline-default-theme)
(display-time-mode t)

(require 'ido)
(ido-mode t)

(require 'evil)
(evil-mode 1) 
;change cursor color depending on mode works only in GUI!!
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional


;more clever indentation
(add-hook 'python-mode-hook 'guess-style-guess-tabs-mode)
   (add-hook 'python-mode-hook (lambda ()
    (when indent-tabs-mode
    (guess-style-guess-tab-width))))

;; Indentation for python
;; Ignoring electric indentation
(defun electric-indent-ignore-python (char)
  "Ignore electric indentation for python-mode"
    (if (equal major-mode 'python-mode)
          'no-indent
              nil))
              (add-hook 'electric-indent-functions 'electric-indent-ignore-python)

              ;; Enter key executes newline-and-indent
              (defun set-newline-and-indent ()
                "Map the return key with `newline-and-indent'"
                  (local-set-key (kbd "RET") 'newline-and-indent))
                   (add-hook 'python-mode-hook 'set-newline-and-indent)
