(require 'evil-leader)
(require 'key-chord)
(setq key-chord-two-keys-delay 0.2)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-normal-state)
(global-evil-leader-mode 1)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "." 'eval-buffer
  "," 'projectile-find-file
  "/" 'dired-jump
  ;; coding options
  "c" 'comment-or-uncomment-region
  "d <SPC>" 'delete-trailing-whitespace
  ;; tables
  "t t" 'orgtbl-mode 
  "t c" 'org-table-insert-column
  "t r" 'org-table-insert-row
  "t h" 'org-table-move-column-left
  "t l" 'org-table-move-column-right
  "t j" 'org-table-move-row-down
  "t k" 'org-table-move-row-up
  "t -" 'org-table-insert-hline
  ;; buffers
  "w" 'save-buffer
  "k" 'kill-buffer 
  "b b" 'switch-to-buffer
  "b n" 'switch-to-buffer-other-window
  "b j" 'next-buffer
  )
(defun prog-kb ()
  (define-key evil-normal-state-map "f" 'hs-toggle-hiding)
  (define-key evil-normal-state-map "F" 'my-toggle-hideshow-all)
  )
(defun latex-kb ()
  (evil-leader/set-key
    "p" 'preview-buffer
    "l e" 'LaTeX-environment
    "l c" 'LaTeX-close-environment
  )
  (define-key evil-normal-state-map "f" 'hide-entry)
  (define-key evil-normal-state-map "F" 'hide-body)
  (define-key evil-normal-state-map "s" 'show-entry)
  (define-key evil-normal-state-map "S" 'show-all)
  )
(defun error-kb ()
  (evil-leader/set-key
    "e e" 'flycheck-list-errors
    "e j" 'flycheck-next-error
    "e k" 'flycheck-previous-error
  )
  )
(add-hook 'prog-mode-hook 'prog-kb)
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


;; toggle hide/show all with a single key.
;; Here are a few lines of code that lets me do just that.
(defvar my-hs-hide nil "Current state of hideshow for toggling all.")
  ;;;###autoload
  (defun my-toggle-hideshow-all () "Toggle hideshow all."
    (interactive)
    (setq my-hs-hide (not my-hs-hide))
    (if my-hs-hide
        (hs-hide-all)
      (hs-show-all)))

