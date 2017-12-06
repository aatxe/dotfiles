;; Encoding - use UTF-8 because it's $CURRENT_YEAR.
(set-language-environment "UTF-8")

;; Basic UI - disable all of the default UI elements
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(set-fringe-style '(1 . 1))
(set-face-attribute 'default nil
                    :font "Source Code Pro")
(column-number-mode 1)

;; Mode Line - making our own fast, cheap powerline substitute
(defun render-mode-line (left right)
  (let* ((rendered-left (format-mode-line left))
         (available-width (- (window-total-width) (length rendered-left) 2)))
    (format (format " %%s %%%ds " available-width)
            rendered-left
            (format-mode-line right))))

(setq evil-emacs-state-tag "E"
      evil-normal-state-tag "N"
      evil-insert-state-tag "I"
      evil-motion-state-tag "M"
      evil-replace-state-tag "R"
      evil-operator-state-tag "O"
      evil-visual-state-tag "V")

(setq-default mode-line-format
              '((:eval (render-mode-line
                        '(""
                          evil-mode-line-tag
                          " %* %b [%m]")
                        "%l:%c"))))

;; Sane Defaults - disable some ridiculous default behavior.
(setq vc-follow-symlinks t
      ring-bell-function 'ignore
      sentence-end-double-space nil
      create-lockfiles nil
      inhibit-startup-message t
      initial-scratch-message "")
(setq-default indent-tabs-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; Backups
(setq delete-old-versions -1
      version-control t
      vc-make-backup-files t
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

;; Custom File - set path and create it if it doesn't exist.
(defvar custom-file-path (concat user-emacs-directory "auto_custom.el"))
(unless (file-exists-p custom-file-path)
  (write-region "" nil custom-file-path))
(setq custom-file custom-file-path)
(load custom-file)

;; Exec Path - add /usr/local/bin to exec path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; Package
(require 'package)

(setq package-enable-at-startup nil)
(setq package-archives '(("gnu"          . "https://elpa.gnu.org/packages/")
			 ("melpa"        . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))
(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; Helper Functions

(defun awe-reload-emacs-config () (interactive)
       (load-file (concat user-emacs-directory "init.el")))

;; Packages

;; general - keybindings
(use-package general
  :ensure t
  :config
  ;; macOS style bindings (some old habits die hard)
  (general-define-key
   :states '(normal motion emacs insert)
   "M-c" 'evil-yank
   "M-v" 'evil-paste-after
   "M-q" 'evil-quit-all)
  ;; spacemacs style bindings
  (general-define-key
   :states '(normal motion emacs)
   :prefix "SPC"
   ;; top-level shortcuts
   "SPC" 'execute-extended-command
   "TAB" 'evil-switch-to-windows-last-buffer
   "!"   'shell-command
   ;; buffer menu - b
   "bd" 'kill-buffer
   "bb" 'switch-to-buffer
   "bn" 'next-buffer
   "bp" 'previous-buffer
   ;; comments menu - c
   "cl" 'evil-commentary-line
   ;; execute mode - e
   "eb" 'eval-buffer
   "ec" 'execute-extended-command
   "ee" 'eval-expression
   ;; files menu - f
   "ff" 'find-file
   "fo" 'find-file
   "fr" 'awe-reload-emacs-config
   ;; insert menu - i
   "iu" 'counsel-unicode-char
   ;; quit menu - q
   "qq" 'evil-quit-all
   ;; toggle menu - t
   "tw" 'whitespace-mode
   ;; windows menu - w
   "wc" 'evil-window-delete
   "wd" 'evil-window-delete
   "wv" 'split-window-right
   "ws" 'split-window-below
   "wh" 'evil-window-left
   "wj" 'evil-window-down
   "wk" 'evil-window-up
   "wl" 'evil-window-right))

;; which-key - popup key binding help
(use-package which-key
  :ensure t
  :defer t
  :init
  (which-key-mode)
  (which-key-add-key-based-replacements
   "SPC b" "buffers"
   "SPC c" "comments"
   "SPC d" "describe"
   "SPC e" "execute"
   "SPC f" "files"
   "SPC g" "git"
   "SPC i" "insert"
   "SPC p" "projects"
   "SPC q" "quit"
   "SPC s" "search"
   "SPC t" "toggles"
   "SPC w" "windows"))

;; evil - vim for emacs
(use-package evil
  :ensure t
  :init
  (evil-mode 1)
  (general-define-key
   :states '(normal motion emacs insert)
   "C-h" 'evil-window-left
   "C-j" 'evil-window-down
   "C-k" 'evil-window-up
   "C-l" 'evil-window-right
   "C-u" 'evil-scroll-page-up
   "C-d" 'evil-scroll-page-down
   "TAB" 'evil-indent-line))

;; evil-escape - alternative escape sequences
(use-package evil-escape
  :ensure t
  :defer t
  :init (evil-escape-mode))

;;  evil-commentary - comment things out
(use-package evil-commentary
  :ensure t
  :defer t
  :init (evil-commentary-mode))

;; ivy - generic completion framework
(use-package ivy
  :ensure t
  :defer t
  :init
  (use-package flx :ensure t :defer t)
  (ivy-mode 1)
  ;; list virtual buffers in completions
  (setq ivy-use-virtual-buffers t)
  ;; improved fuzzy finding
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))
        ivy-initial-inputs-alist nil))

;; counsel - use ivy everywhere
(use-package counsel
  :ensure t
  :defer t
  :init
  (general-define-key
   :states '(normal motion emacs)
   :prefix "SPC"
   ;; describe menu - d
   "dc" 'describe-char
   "df" 'counsel-describe-function
   "dk" 'describe-key
   "dm" 'describe-mode
   "dv" 'counsel-describe-variable))

;; projectile - give emacs a notion of projects
(use-package projectile
  :ensure t
  :defer t
  :init
  (use-package counsel-projectile
    :ensure t)
  (general-define-key
   :states '(normal motion emacs)
   :prefix "SPC"
   ;; projects menu - p
   "p SPC" 'counsel-projectile
   "pb"    'projectile-switch-to-buffer
   "pd"    'projectile-find-dir
   "pf"    'projectile-find-file
   "pp"    'projectile-find-file
   "pr"    'projectile-recentf)
  :config
  (projectile-global-mode)
  (counsel-projectile-on))

;; swiper - isearch with ivy
(use-package swiper
  :ensure t
  :defer t
  :init
  (general-define-key
   :states '(normal motion emacs)
   :prefix "SPC"
   ;; search menu - s
   "sa" 'swiper-all
   "sf" 'swiper
   "sg" 'counsel-grep
   "ss" 'counsel-rg
   "sr" 'counsel-rg))

;; pinentry - enter pin for gpg commit signing
(use-package pinentry
  :ensure t
  :config
  (pinentry-start))

;; magit - git like magic
(use-package magit
  :ensure t
  :init
  (general-define-key
   :states '(normal motion emacs)
   :prefix "SPC"
   ;; git menu - g
   "gc" 'magit-commit
   "gd" 'magit-diff
   "gl" 'magit-log
   "gp" 'magit-push
   "gP" 'magit-pull
   "gr" 'magit-rebase
   "gs" 'magit-stage-file))

;; evil-magit - evil bindings for magit
(use-package evil-magit
  :ensure t
  :after magit)

;; Editing Packages

;; smartparens - automatically insert and pass through parens
(use-package smartparens
  :ensure t
  :defer t
  :init
  (setq sp-show-pair-delay 0.2
        sp-show-pair-from-inside t
        sp-cancel-autoskip-on-backward-movement nil
        sp-highlight-pair-overlay nil
        sp-highlight-wrap-overlay nil
        sp-highlight-wrap-tag-overlay nil)
  (general-define-key
   :states '(normal motion emacs)
   :prefix "SPC"
   "tp" 'smartparens-mode)
  :config
  (require 'smartparens-config)
  (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
  (smartparens-mode))

;; Visual Packages

;; fill-column-indicator - draw a line where the fill-column is
(use-package fill-column-indicator
  :ensure t
  :defer t
  :init
  (setq fci-rule-width 1
        fci-rule-color "#D0BF8F")
  (push '(fci-mode "") minor-mode-alist)
  (general-define-key
   :states '(normal motion emacs)
   :prefix "SPC"
   "tf" 'fci-mode))

;; golden-ratio - maintain windows in the golden ratio
(use-package golden-ratio
  :ensure t
  :defer t
  :init
  (general-define-key
   :states '(normal motion emacs)
   :prefix "SPC"
   "tg" 'golden-ratio-mode))

;; highlight-parentheses - highlight the surrounding parens
(use-package highlight-parentheses
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
  (setq hl-paren-colors '("Springgreen3"
                          "IndianRed1"
                          "IndianRed3"
                          "IndianRed4"))
  :config
  (highlight-parentheses-mode))

;; linum-relative - relative line numbering is the bomb
(use-package linum-relative
  :ensure t
  :defer t
  :init
  (setq linum-format "%4d")
  ;; show current line number as current symbol
  (setq linum-relative-current-symbol "")
  (add-hook 'prog-mode-hook 'linum-relative-mode))

;; rainbow-delimiters - color all the delimiters in rainbow colors
(use-package rainbow-delimiters
  :ensure t
  :defer t
  :init
  (general-define-key
   :states '(normal motion emacs)
   :prefix "SPC"
   "tr" 'rainbow-delimiters-mode))
