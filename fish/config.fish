# GPG_TTY for terminal pinentry
set -x GPG_TTY (tty)
# Add cargo to path.
set -x PATH $HOME/.cargo/bin $PATH
# Add .local/bin to path.
set -x PATH $HOME/.local/bin $PATH
# Run ssh-agent if not on macOS.
if [ (uname) != "Darwin" ]
    eval (ssh-agent -c)
    ssh-add
end
