; hook to run file at the very end of this script
(add-hook 'after-init-hook '(lambda ()
                                (load "~/.emacs.d/my-noexternals.el")
                                ))



(load "~/.emacs.d/my-loadpackages.el")

; syntax checking
;(add-hook 'after-init-hook #'global-flycheck-mode)
; need to install: pip install pylint, in order to get python syntax check

; add line number in programming mode
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook 'show-paren-mode)

; insert matching parenthesis
(electric-pair-mode 1)


(evil-mode 1) 

(require 'auto-complete)
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional



(load-theme 'zenburn t)
;(require 'color-theme-sanityinc-tomorrow)
;(color-theme-sanityinc-tomorrow--define-theme bright)

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

; Overload shifts so that they don't lose the selection
(define-key evil-visual-state-map (kbd ">") 'evil-shift-right-visual)
(define-key evil-visual-state-map (kbd "<") 'evil-shift-left-visual)
;(define-key evil-visual-state-map [tab] 'evil-shift-right-visual)
;(define-key evil-visual-state-map [S-tab] 'evil-shift-left-visual)

(defun evil-shift-left-visual ()
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun evil-shift-right-visual ()
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

   ;;; esc quits
(defun minibuffer-keyboard-quit ()
    "Abort recursive edit.
  In Delete Selection mode, if the mark is active, just deactivate it;
  then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
     (setq deactivate-mark  t)
     (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
     (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

; get some basic emacs functions back
(define-key evil-normal-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-y" 'yank)
(define-key evil-visual-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-insert-state-map "\C-r" 'search-backward)

;(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
