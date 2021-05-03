(setq inhibit-startup-message t)
(setq visible-bell t)

(load-theme 'wombat)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux distributions
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-is-search-kill))
  :config
  (ivy-mode 1))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(defun aschl/org-mode-setup ()
	(org-indent-mode)
;;	(variable-pitch-mode 1)
	(auto-fill-mode 0)
	(visual-line-mode 1)
	(setq evil-auto-indent nil))

(use-package org
	:hook (org-mode . aschl/org-mode-setup)
	:config
	(setq org-hide-emphasis-markers t))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)))

(push '("conf-unix" . conf-unix) org-src-lang-modes)

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

;; IDE

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(defun aschl/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . aschl/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy
  :after lsp)

(use-package dap-mode
  :commands dap-debug
  :config
  (require 'dap-node)
  (dap-node-setup)
  (general-define-key
   :keymap 'lsp-mode-map
   :prefix lsp-keymap-prefix))
;;   "d" '(dap-hydra t :wk "debugger")))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))

  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; .NET Development (C#/F#)

(use-package csharp-mode
  :mode "\\.cs\\'"
  :hook (csharp-mode . lsp-deferred))

(use-package dotnet
  :hook (csharp-mode . dotnet-mode)
  :init
  (setq dotnet-mode-keymap-prefix "C-c n"))

;; C/C++ Development

;; Powershell

;; Bash

;; XML

;; YAML

;; HTML/CSS

;; JavaScript/Typescript

;; Python

;; Rust

;; Go

;; Docker/Kubernetes/OpenShift

;; Use Dockerfile for LSP instead
(use-package dockerfile-mode :ensure t)

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

;; Terminals

(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))

;; Multimedia

(use-package emms :ensure t)

;; epub

;; cloud access (Nextcloud/Dropbox/OneDrive/...)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(emms use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
