# dotfiles

Personal configuration files for shell, editors, and window managers.

## Installation

```bash
bash install.sh
```

Select the modules you want to install when prompted. Each module symlinks the relevant config files and sets up plugin managers where applicable.

## Modules

### zsh

Z shell configuration with powerlevel10k theme.

- **Required:** `zsh`, `git`
- **Plugins (auto-installed):** antigen, powerlevel10k, zsh-syntax-highlighting

### neovim

Neovim configuration with lazy.nvim plugin manager.

- **Required:** `neovim`, `git`, `make`
- **Plugins (auto-installed):** telescope, treesitter, mason, nvim-lspconfig, blink.cmp, gitsigns, nvim-tree, copilot, conform, which-key, tokyonight, lualine
- **LSP servers (installed via Mason):** lua_ls, basedpyright, clangd, rust_analyzer, jsonls, yamlls, marksman, ruff
- **Formatters:** `stylua`, `prettier` (installed via Mason)
- **Optional:** Nerd Font (for icons)

### sway

Sway Wayland compositor with waybar.

- **Required:** `sway`, `foot`, `fuzzel`, `waybar`
- **Optional:** `brightnessctl`, `grim` (screenshots), `wdisplays`, `pactl` (volume)
- **Fonts:** Font Awesome 6 Free (for waybar icons)

### vim

Vim configuration with Vundle plugin manager.

- **Required:** `vim`, `git`
- **Plugins (auto-installed):** airline, fugitive, nerdtree, python-mode, jedi-vim, molokai
- **Optional:** `pyflakes`, `pep8` (Python linting)

### spacemacs

Spacemacs distribution configuration.

- **Required:** `emacs`, `git`
- **Layers:** c-c++, python (black, LSP), latex, markdown, javascript, yaml, git, helm, org
- **Optional:** `ag` (search), `ipython`, `black`, `vmd` (markdown preview)
- **Font:** Source Code Pro

### i3

i3 window manager with i3blocks.

- **Required:** `i3`, `termite`, `rofi`, `i3blocks`
- **Optional:** `compton` (transparency), `scrot` (screenshots), `ranger`, `playerctl`, `feh`, `xbacklight`, `i3lock`
- **Fonts:** DejaVu Sans Mono for Powerline, FontAwesome

### emacs

Vanilla Emacs configuration.

- **Required:** `emacs`
- **Packages (auto-installed via ELPA/MELPA):** auctex, auto-complete, elpy, evil, flycheck, jedi, markdown-mode, material-theme, powerline
- **Optional:** `ipython`, `pylint`, LaTeX distribution
