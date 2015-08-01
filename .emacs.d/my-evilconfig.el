
(require 'evil-leader)
(global-evil-leader-mode 1)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "." 'eval-buffer
  "," 'projectile-find-file
  "t" 'dired-jump
  "c" 'comment-or-uncomment-region
  "w" 'save-buffer
  "k" 'kill-buffer 
  "b b" 'switch-to-buffer
  "b n" 'switch-to-buffer-other-window
  "b j" 'next-buffer
  )
(defun latex-kb ()
(evil-leader/set-key
  "p" 'preview-buffer
  ))
(defun error-kb ()
(evil-leader/set-key
  "e e" 'flycheck-list-errors
  "e j" 'flycheck-next-error
  "e k" 'flycheck-previous-error
  ))
(add-hook 'LaTeX-mode-hook 'latex-kb)
(add-hook 'flycheck-mode-hook 'error-kb)


(evil-mode 1)
(require 'evil)
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
(define-key evil-visual-state-map [tab] 'evil-shift-right-visual)
(define-key evil-visual-state-map [S-tab] 'evil-shift-left-visual)
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

; esc quits
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

; go down on visual line, not real line with j and k
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

; changing windows
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)


; other keybindings

(define-key evil-normal-state-map "f" 'hs-toggle-hiding)
(define-key evil-normal-state-map "F" 'hs-hide-all)

