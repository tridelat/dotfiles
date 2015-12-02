; package archives
(require 'package)
(add-to-list 'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
   '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

; packages to be installed
(defvar required-packages
    '(
      auctex
      auto-complete
      column-marker
      evil
      evil-leader
      evil-search-highlight-persist
      flycheck
      ipython
      jedi
      org
      powerline
      projectile
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



