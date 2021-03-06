; package archives
(require 'package)
(add-to-list 'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
   '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

; packages to be installed
(defvar required-packages
    '(
      auctex
      auto-complete
      auto-complete-auctex
      column-marker
      elpy
      evil
      evil-leader
      evil-search-highlight-persist
      flycheck
      ipython
      jedi
      key-chord
      markdown-mode
      material-theme
      org
      ox-gfm
      powerline
      projectile
      python-mode
      smex  ; autocomplete commands
      color-theme-sanityinc-tomorrow monokai-theme molokai-theme zenburn-theme solarized-theme
                      ) "a list of packages to ensure are installed at launch.")

(require 'cl)

; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
       when (not (package-installed-p p)) do (return nil)
       finally (return t)))


; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
   ; check for new packages (package versions)
   (message "%s" "Emacs is now refreshing its package database...")
   (package-refresh-contents)
   (message "%s" " done.")
   ; install the missing packages
   (dolist (p required-packages)
        (when (not (package-installed-p p))
            (package-install p))))




