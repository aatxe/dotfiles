;;; elegance-theme.el - a greyscale lack-of-color theme by Aaron Weiss

;; Copyright (c) 2017 Aaron Weiss

;; Author: Aaron Weiss <awe@pdgn.co>
;;
;; URL: https://github.com/aatxe/dotfiles
;; Version: 1.0.0

;; Package-Requires: ((autothemer "0.2"))

;;; Code:
(eval-when-compile
  (require 'cl-lib))

(require 'autothemer)

;; assumed based on gruvbox
(unless (>= emacs-major-version 24)
  (error "Requires Emacs 24 or later"))
;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(autothemer-deftheme
 elegance
 "An Emacs color theme by Aaron Weiss"

 ;; Color Palette:
 ((((class color) (min-colors #xFFFFFF))
   ((class color) (min-colors #xFF)))

  (elegance-bg-primary "#282828" nil)
  (elegance-bg-secondary "#212121" nil)
  (elegance-bg-tertiary "#303030" nil)
  (elegance-fg-primary "#6D6D6D" nil)
  (elegance-fg-secondary "#3F3F3F" nil)
  (elegance-fg-tertiary "#7D7D7D" nil)

  (elegance-delimiter-one "#7D7D7D" nil)
  (elegance-delimiter-two "#9D9D9D" nil)
  (elegance-delimiter-three "#8D8D8D" nil)
  (elegance-delimiter-four "#ADADAD" nil)

  (elegance-red "#847777" nil)
  (elegance-green "#6A8471" nil)
  (elegance-yellow "#747165" nil)
  (elegance-blue "#60676B" nil)
  (elegance-purple "#847782" nil)
  (elegance-cyan "#606B6B" nil))

 ;; Specifications:
 ((default (:background elegance-bg-primary :foreground elegance-fg-primary))
  (cursor (:background elegance-bg-secondary))
  (mode-line (:background elegance-bg-primary :foreground elegance-fg-primary :box nil))
  (mode-line-inactive (:background elegance-bg-primary :foreground elegance-fg-primary :box nil))
  (fringe (:background elegance-bg-primary))
  (hl-line (:background elegance-bg-secondary))
  (region (:background elegance-bg-tertiary))
  (secondary-selection (:background elegance-bg-secondary))
  (minibuffer-prompt (:foreground elegance-fg-tertiary :bold t))
  (vertical-border (:foreground elegance-bg-primary))
  (window-divider (:foreground elegance-bg-primary))
  (link (:foreground elegance-blue :underline t))
  (shadow (:foreground elegance-bg-secondary))

  ;; Built-in Syntax
  (font-lock-builtin-face (:foreground elegance-fg-primary))
  (font-lock-constant-face (:foreground elegance-fg-primary :bold t))
  (font-lock-string-face (:foreground elegance-fg-primary))
  (font-lock-comment-face (:foreground elegance-fg-secondary))
  (font-lock-doc-face (:foreground elegance-fg-secondary))
  (font-lock-function-name-face (:foreground elegance-fg-tertiary :italic t))
  (font-lock-variable-name-face (:foreground elegance-fg-primary :italic t))
  (font-lock-keyword-face (:foreground elegance-fg-primary))
  (font-lock-type-face (:foreground elegance-fg-tertiary :italic t))
  (font-lock-warning-face (:foreground elegance-fg-tertiary :bold t))

  ;; evil ex
  (evil-ex-commands (:foreground elegance-fg-primary))
  (evil-ex-info (:foreground elegance-fg-tertiary))
  (evil-ex-lazy-highlight (:background elegance-bg-primary))
  (evil-ex-search (:background elegance-bg-secondary))
  (evil-ex-substitute-matches (:background elegance-bg-primary))
  (evil-ex-substitute-replacement (:foreground elegance-fg-tertiary :italic t))

  ;; rainbow delimiters
  (rainbow-delimiters-depth-1-face    (:foreground elegance-delimiter-one))
  (rainbow-delimiters-depth-2-face    (:foreground elegance-delimiter-two))
  (rainbow-delimiters-depth-3-face    (:foreground elegance-delimiter-three))
  (rainbow-delimiters-depth-4-face    (:foreground elegance-delimiter-four))
  (rainbow-delimiters-depth-5-face    (:foreground elegance-delimiter-one))
  (rainbow-delimiters-depth-6-face    (:foreground elegance-delimiter-two))
  (rainbow-delimiters-depth-7-face    (:foreground elegance-delimiter-three))
  (rainbow-delimiters-depth-8-face    (:foreground elegance-delimiter-four))
  (rainbow-delimiters-depth-9-face    (:foreground elegance-delimiter-one))
  (rainbow-delimiters-depth-10-face   (:foreground elegance-delimiter-two))
  (rainbow-delimiters-depth-11-face   (:foreground elegance-delimiter-three))
  (rainbow-delimiters-depth-12-face   (:foreground elegance-delimiter-four))
  (rainbow-delimiters-unmatched-face  (:background nil :foreground elegance-fg-tertiary))

  ;; smartparens
  (sp-pair-overlay-face (:background nil :foreground elegance-delimiter-four :bold t))
  (sp-wrap-overlay-face (:background nil :foreground elegance-delimiter-four :bold t))
  (sp-wrap-overlay-opening-pair (:background nil :foreground elegance-delimiter-four :bold t))
  (sp-show-pair-match-face (:background elegance-bg-tertiary :foreground elegance-delimiter-one))
  (sp-show-pair-mismatch-face (:background elegance-bg-tertiary :foreground elegance-red))

  ;; line numbers
  (line-number (:foreground elegance-fg-secondary :background elegance-bg-primary))
  (line-number-current-line (:foreground elegance-fg-primary :background elegance-bg-primary))
  (linum (:foreground elegance-fg-secondary :background elegance-bg-primary))
  (linum-highlight-face (:foreground elegance-fg-primary :background elegance-bg-primary))
  (linum-relative-current-face (:foreground elegance-fg-primary :background elegance-bg-primary))

  ;; company-mode
  (company-scrollbar-bg (:background elegance-bg-primary))
  (company-scrollbar-fg (:background elegance-bg-tertiary))
  (company-tooltip (:background elegance-bg-tertiary :box elegance-bg-secondary))
  (company-tooltip-annotation (:foreground elegance-fg-tertiary :italic t))
  (company-tooltip-annotation-selection (:inherit 'company-tooltip-annotation))
  (company-tooltip-selection (:foreground elegance-fg-tertiary :background elegance-bg-primary))
  (company-tooltip-common (:foreground elegance-fg-tertiary))
  (company-tooltip-common-selection (:foreground elegance-fg-tertiary :bold t))
  (company-preview-common (:foreground elegance-fg-primary))
  (company-preview (:background elegance-blue))
  (company-preview-search (:background elegance-blue))

  ;; ivy
  (ivy-current-match (:foreground elegance-fg-tertiary :bold t :background elegance-bg-secondary))
  (ivy-minibuffer-match-face-1 (:foreground elegance-fg-primary))
  (ivy-minibuffer-match-face-2 (:foreground elegance-fg-primary :italic t))
  (ivy-minibuffer-match-face-3 (:foreground elegance-fg-primary :bold t))
  (ivy-minibuffer-match-face-4 (:foreground elegance-fg-primary :bold t))

  ;; powerline
  (spaceline-python-venv (:foreground elegance-fg-tertiary))
  (powerline-active0 (:foreground elegance-fg-primary))
  (powerline-active1 (:background elegance-bg-secondary :foreground elegance-fg-tertiary))
  (powerline-active2 (:background elegance-bg-tertiary :foreground elegance-fg-primary))
  (powerline-inactive0 (:foreground elegance-fg-primary))
  (powerline-inactive1 (:background elegance-bg-secondary :foreground elegance-fg-tertiary))
  (powerline-inactive2 (:background elegance-bg-tertiary :foreground elegance-fg-primary))

  ;; mode indicating colors
  (spacemacs-emacs-face (:background elegance-cyan))
  (spacemacs-insert-face (:background elegance-green))
  (spacemacs-motion-face (:background elegance-purple))
  (spacemacs-normal-face (:background elegance-yellow))
  (spacemacs-replace-face (:background elegance-red))
  (spacemacs-visual-face (:background elegance-fg-tertiary))
  (spaceline-evil-emacs (:background elegance-cyan))
  (spaceline-evil-insert (:background elegance-green))
  (spaceline-evil-motion (:background elegance-purple))
  (spaceline-evil-normal (:background elegance-yellow))
  (spaceline-evil-replace (:background elegance-red))
  (spaceline-evil-visual (:background elegance-fg-tertiary)))

  ;; Evaluated Forms:
  (custom-theme-set-variables 'elegance
                              `(hl-paren-colors
                                '(,elegance-green
                                  ,elegance-red
                                  ,elegance-blue
                                  ,elegance-purple))
                              `(ansi-color-names-vector
                                [,elegance-bg-primary
                                 ,elegance-red
                                 ,elegance-green
                                 ,elegance-yellow
                                 ,elegance-blue
                                 ,elegance-purple
                                 ,elegance-cyan
                                 ,elegance-fg-primary])))

(provide-theme 'elegance)
(provide 'elegance-theme)
