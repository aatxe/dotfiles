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
      (tool-bar-mode -1)))

;; fix for sonoma huge title bar bug
(add-hook 'doom-after-init-hook (lambda () (tool-bar-mode 1) (tool-bar-mode 0)))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ariel Weiss"
      user-mail-address "arielweiss@roblox.com")

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
(setq doom-font (font-spec :family "Berkeley Mono" :size 14 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)

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

(add-to-list 'auto-mode-alist '("\\.luau\\'" . lua-mode))

(use-package! eglot-luau
  :demand t
  :after (lua-mode eglot)
  :functions eglot-luau-setup
  :config (eglot-luau-setup)
  :hook (lua-mode . eglot-ensure))

(after! eglot-luau
  (setq eglot-luau-fflag-overrides '(("LuauSolverV2" "True"))))

(defun get-luau-unittest-path (mode)
  (let* ((default-directory (projectile-project-root))
         (output-lines (split-string
                        (shell-command-to-string
                         (concat "buck2 build //Client/Luau:Luau.UnitTest --show-output @modes//macos//commontests-arm64" " " mode))
                        "\n" t))
         (last-line (car (last output-lines)))
         (build-path (nth 1 (split-string last-line " "))))
    (string-trim build-path)))

(defun get-script-services-path (mode)
  (let* ((default-directory (projectile-project-root))
         (output-lines (split-string
                        (shell-command-to-string
                         (concat "buck2 build //Client/Luau:Luau.UnitTest --show-output @modes//macos//commontests-arm64" " " mode))
                        "\n" t))
         (last-line (car (last output-lines)))
         (build-path (nth 1 (split-string last-line " "))))
    (string-trim build-path)))

(after! dape
  (setq dape-cwd-function 'projectile-project-root)
  (setq dape-buffer-window-arrangement 'right)

  (let ((codelldb
         `( ensure dape-ensure-command
            command-cwd dape-command-cwd
            command ,(file-name-concat dape-adapter-dir
                                       "codelldb"
                                       "extension"
                                       "adapter"
                                       "codelldb")
            command-args ("--port" :autoport)
            port :autoport
            :type "lldb"
            :request "launch"
            :cwd ".")))

        (add-to-list 'dape-configs
                `(lut
                        modes (c++-mode)
                        ,@codelldb
                        :program ,(lambda () (get-luau-unittest-path "@modes//noopt"))
                        :args #1=["--fflags=true,LuauSolverV2=true"]
                        :preRunCommands #2=["command script import ./Client/Luau/tools/lldb_formatters.py",
                                            "command source ./Client/Luau/tools/lldb_formatters.lldb"]))
        (add-to-list 'dape-configs
                `(lut-opt
                        modes (c++-mode)
                        ,@codelldb
                        :program ,(lambda () (get-luau-unittest-path "@modes//optimized"))
                        :args #1=["--fflags=true,LuauSolverV2=true"]
                        :preRunCommands #2=["command script import ./Client/Luau/tools/lldb_formatters.py",
                                            "command source ./Client/Luau/tools/lldb_formatters.lldb"]))
        (add-to-list 'dape-configs
                `(ss
                        modes (c++-mode)
                        ,@codelldb
                        :program ,(lambda () (get-script-services-path "@modes//noopt"))
                        :args #1=["--fflags=true,LuauSolverV2=true"]
                        :preRunCommands #2=["command script import ./Client/Luau/tools/lldb_formatters.py",
                                            "command source ./Client/Luau/tools/lldb_formatters.lldb"]))
        (add-to-list 'dape-configs
                `(ss-opt
                        modes (c++-mode)
                        ,@codelldb
                        :program ,(lambda () (get-script-services-path "@modes//optimized"))
                        :args #1=["--fflags=true,LuauSolverV2=true"]
                        :preRunCommands #2=["command script import ./Client/Luau/tools/lldb_formatters.py",
                                            "command source ./Client/Luau/tools/lldb_formatters.lldb"]))))

;; evil escape sequence should be fd
(after! evil-escape
  (setq evil-escape-key-sequence "fd"))

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

      ;;; <leader> d --- debugger
      (:prefix-map ("d" . "debug")
       :desc "Dape open a debugger instance"           "d"   #'dape
       :desc "Dape quit the current debugger instance" "q"   #'dape-quit
       :desc "Dape toggle breakpoint at line"          "b"   #'dape-breakpoint-toggle
       :desc "Dape clear all breakpoints"              "B"   #'dape-breakpoint-remove-all
       :desc "Dape pause program under debugger"       "p"   #'dape-pause
       :desc "Dape continue program execution"         "c"   #'dape-continue
       :desc "Dape switch to repl"                     "r"   #'dape-repl
       :desc "Dape restart debugger session"           "R"   #'dape-restart
       :desc "Dape next in debugger"                   "n"   #'dape-next
       :desc "Dape step-in in debugger"                "s"   #'dape-step-in
       :desc "Dape step-in in debugger"                "o"   #'dape-step-out
       :desc "Dape add watch expression"               "w"   #'dape-watch-dwim
       :desc "Dape select stackframe by index"         "S"   #'dape-select-stack
       :desc "Dape select thread by index"             "t"   #'dape-select-thread
       :desc "Dape step down in callstack"             "k" #'dape-stack-select-down
       :desc "Dape step up in callstack"               "j"   #'dape-stack-select-up)

      ;;; <leader> l --- latex
      (:prefix-map ("l" . "latex")
       (:when (modulep! :lang latex)
        :desc "LaTeX fill region" "r" #'LaTeX-fill-region))

      ;;; <leader> g --- git
      (:prefix-map ("g" . "git")
       (:when (modulep! :tools magit)
        :desc "Magit push current to upstream" "p" #'magit-push-current-to-upstream
        :desc "Magit push current"             "P" #'magit-push-current)))
