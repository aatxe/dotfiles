export GPG_TTY=$(tty)
export PATH=$PATH:$HOME/.cargo/bin:$HOME/.cabal/bin:/usr/local/Cellar/python/2.7.9/Frameworks/Python.framework/Versions/2.7/bin
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias ls="ls -G"
alias aplay="play -t u8 -"
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
export OPENSSL_LIB_DIR=/usr/local/opt/openssl/lib

# added by travis gem
[ -f /Users/awe/.travis/travis.sh ] && source /Users/awe/.travis/travis.sh
