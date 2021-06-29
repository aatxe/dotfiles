# homebrew
eval (/opt/homebrew/bin/brew shellenv)
# GPG_TTY for terminal pinentry
set -x GPG_TTY (tty)
# Add cargo to path.
set -x PATH $HOME/.cargo/bin $PATH
# Add .local/bin to path.
set -x PATH $HOME/.local/bin $PATH
# Add emacs to path.
set -x PATH $HOME/.emacs.doom/bin $PATH
# Add LaTeX tools to path.
set -x PATH /Library/TeX/texbin $PATH
set -g fish_user_paths "/usr/local/opt/zip/bin" $fish_user_paths
# opam
eval (opam env)
