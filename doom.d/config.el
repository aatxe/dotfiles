;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; default window size should be reasonable, title bar should be transparent
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist '((width . 120)
                                  (height . 50)))
      (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
      (add-to-list 'default-frame-alist '(ns-appearance . dark))
      (setq ns-use-proxy-icon nil)
      (setq frame-title-format nil)
      (tool-bar-mode -1)))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Aaron Weiss"
      user-mail-address "aweiss@hey.com")

;; start pinentry for commit signing
(pinentry-start)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; swap surround and substitution in evil
(after! evil-surround
  (progn
    (evil-define-key 'visual evil-surround-mode-map "s" 'evil-surround-region)
    (evil-define-key 'visual evil-surround-mode-map "S" 'evil-substitute)))

;; golden ratio for coq-mode
(add-hook! coq-mode 'golden-ratio-mode)

;; no proof-general abbreviations in coq-mode
(add-hook! coq-mode
        (lambda () (clear-abbrev-table coq-mode-abbrev-table)))

;; follow symbolic links automatically.
(setq vc-follow-symlinks t)

;; set default fill-column to 100 charactres, but 80 for LaTeX
(setq-default fill-column 100)
(add-hook! LaTeX-mode (lambda () (setq fill-column 80)))

;; <leader> keybindings
(map! :leader
      :desc "M-x"                   "SPC"  #'execute-extended-command
      :desc "Switch to last buffer" "TAB"  #'evil-switch-to-windows-last-buffer

      ;;; <leader> g --- git
      (:prefix-map ("g" . "git")
       (:when (featurep! :tools magit)
        :desc "Magit push current to upstream" "p" #'magit-push-current-to-upstream
        :desc "Magit push current"             "P" #'magit-push-current)))
