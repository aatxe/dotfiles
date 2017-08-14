;;; packages.el --- fstar layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Aaron Weiss <awe@pdgn.co>
;; URL: https://github.com/aatxe/dotfiles
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `fstar-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `fstar/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `fstar/pre-init-PACKAGE' and/or
;;   `fstar/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst fstar-packages
  '(fstar-mode
    smartparens))

(defun fstar/init-fstar-mode ()
  (use-package fstar-mode
    :defer t
    :init
    (progn
      ;; Load fsi files in F* mode.
      (add-to-list 'auto-mode-alist '("\\.fsi\\'" . fstar-mode))
      )
    :config
    (progn
      ;; Prefixes
      (spacemacs/declare-prefix-for-mode 'fstar-mode "mg" "fstar/goto")
      (spacemacs/declare-prefix-for-mode 'fstar-mode "mh" "fstar/documentation")
      (spacemacs/declare-prefix-for-mode 'fstar-mode "mi" "fstar/editing")
      (spacemacs/declare-prefix-for-mode 'fstar-mode "mp" "fstar/prover")

      ;; Keybindings
      (spacemacs/set-leader-keys-for-major-mode 'fstar-mode
        ;; Basic proof management
        "]" 'fstar-subp-advance-next
        "[" 'fstar-subp-retract-last
        "." 'fstar-subp-advance-or-retract-to-point
        "," 'fstar-subp-advance-or-retract-to-point-lax

        ;; Shorthands: shorter options for common functionality
        "b" 'fstar-subp-advance-to-point-max-lax
        "c" 'fstar-insert-match-dwim
        "q" 'fstar-subp-kill-one-or-many
        "s" 'fstar-search
        "t" 'fstar-doc

        ;; Prover interaction
        "pb" 'fstar-subp-advance-to-point-max-lax
        "po" 'fstar-subp-start
        "pq" 'fstar-subp-kill-one-or-many
        "pi" 'fstar-subp-kill-z3
        "pr" 'fstar-subp-reload-to-point

        ;; Interactive editing.
        "ic" 'fstar-insert-match-dwim
        "ie" 'fstar-eval
        "ir" 'fstar-subp-reload-to-point
        "is" 'fstar-search

        ;; Documentation
        "hd" 'fstar-doc
        "hp" 'fstar-print
        "hw" 'fstar-browse-wiki

        ;; Gotos
        "gi" 'fstar-visit-interface-or-implementation
        "gl" 'fstar-subp-goto-beginning-of-untracked-region
        ))))

(defun fstar/post-init-smartparens ()
  (spacemacs/add-to-hooks (if dotspacemacs-smartparens-strict-mode
                              'smartparens-strict-mode
                            'smartparens-mode)
                          '(fstar-mode-hook)))

;;; packages.el ends here
