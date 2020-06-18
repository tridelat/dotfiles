:;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.


(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(csv
     html
     better-defaults
     spell-checking
     auto-completion
     (c-c++ :variables
            c-c++-enable-clang-support t
            clang-format-style "file")
     chinese
     django
     emacs-lisp
     helm
     games
     git
     ipython-notebook
     languagetool
     (languagetool :variables
                   langtool-default-language "en-GB")
     (latex :variables
            latex-enable-auto-fill t
            latex-enable-folding t)
     (markdown :variables
               markdown-live-preview-engine 'vmd)
     pdf-tools
     org
     python
     restructuredtext
     semantic
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     smex
     sphinx
     syntax-checking
     version-control
     themes-megapack
     yaml)
   dotspacemacs-additional-packages '(eyebrowse flyspell)
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(evil-indent-textobject)
   dotspacemacs-install-packages 'used-only
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5

   dotspacemacs-startup-lists '(recents projects)
   dotspacemacs-themes '(monokai
                         ;; base16-monokai-dark
                         spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("DejaVu Sans Mono"
                               :size 11
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-command-key ":"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-use-ido t
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-micro-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-smartparens-strict-mode t
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-line-numbers t
   dotspacemacs-folding-method 'evil
   ))

(defun dotspacemacs/user-init ()
  )


(defun dotspacemacs/user-config ()

  ;; ---------------------------
  ;; --------- GENERAL ---------
  ;; ---------------------------
  ;; replace tab by space
  (setq-default indent-tabs-mode nil)
  ;; line numbers
  ;; (global-linum-mode t)
  ;; fill column length
  (setq-default fill-column 79)
  ;; ido flex matching
  (setq ido-enable-flex-matching t)
  ;; org tables accessible from all modes
  (turn-on-orgtbl)
  ;; autocomplete
  (global-auto-complete-mode 1)

  ;; ---------------------------
  ;; ------- PROGRAMMING -------
  ;; ---------------------------
  ;; General
  (defun my-prog-options ()
    (fci-mode t)
    )
  (add-hook 'prog-mode-hook 'my-prog-options)

  ;; Python
  (setq python-shell-interpreter "ipython")

  ;; LaTeX
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)  ;; auto preview when opening
  ;; (setq TeX-engine 'luatex)

  ;; ---------------------------
  ;; ------ KEY BINDINGS -------
  ;; ---------------------------
  ;; Evil bindings
  (setq-default evil-escape-key-sequence "jk")
  (define-key evil-normal-state-map "f" 'hs-toggle-hiding)
  (define-key evil-normal-state-map "F" 'my-toggle-hideshow-all)
  (spacemacs/declare-prefix "o" "custom")
  (spacemacs/declare-prefix "o t" "org-table")
  (evil-leader/set-key
    ;; org tables
    "o t t" 'orgtbl-mode
    "o t c" 'org-table-insert-column
    "o t r" 'org-table-insert-row
    "o t h" 'org-table-move-column-left
    "o t l" 'org-table-move-column-right
    "o t j" 'org-table-move-row-down
    "o t k" 'org-table-move-row-up
    "o t -" 'org-table-insert-hline
    )
  ;; toggle hide/show all with a single key.
  (defvar my-hs-hide nil "Current state of hideshow for toggling all.")
  (defun my-toggle-hideshow-all () "Toggle hideshow all."
  (interactive)
  (setq my-hs-hide (not my-hs-hide))
  (if my-hs-hide
      (hs-hide-all)
      (hs-show-all)
      )
  )

)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
)
