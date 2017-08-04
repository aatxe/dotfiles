#!/usr/bin/env sh

# Install a number of additional packages via Homebrew.
# These are most likely going to consist of programming languages and dev dependencies.

# Languages

brew install fstar
brew install haskell-stack
brew install idris
brew install mono
brew install node
brew install ocaml opam
brew install scala sbt

brew cask install java
brew cask install mactex
brew cask install racket

# Common Dev Dependencies
brew install cmake graphviz imagemagick wget z3
brew cask install vagrant virtualbox
