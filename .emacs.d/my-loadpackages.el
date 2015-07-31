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
      deferred ; needed for jedi
      epc   ; needed for jedi
      evil
      evil-leader
      evil-search-highlight-persist
      flycheck
      jedi
      powerline
      python-environment    ; required for jedi
      color-theme-sanityinc-tomorrow monokai-theme molokai-theme zenburn-theme solarized-theme
      virtualenv    ; required for jedi
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




