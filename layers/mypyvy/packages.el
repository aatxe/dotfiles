;;; packages.el --- mypyvy layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Aaron Weiss <awe@zenaida>
;; URL: https://github.com/syl20bnr/spacemacs
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
;; added to `mypyvy-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `mypyvy/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `mypyvy/pre-init-PACKAGE' and/or
;;   `mypyvy/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst mypyvy-packages
  '((mypyvy-mode :location local)
    (flycheck-mypyvy :location local)))

(defun mypyvy/init-mypyvy-mode ()
  (use-package mypyvy-mode
    :load-path "~/Develop/Python/mypyvy/emacs/"))

(defun mypyvy/init-flycheck-mypyvy ()
  (use-package flycheck-mypyvy
    :load-path "~/Develop/Python/mypyvy/emacs/"))

;;; packages.el ends here
