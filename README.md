# dotfiles #
These are my configuration files.

## Setup Process ##
The current setup process looks something like this:

  1. Run the platform-specific configuration script (e.g. `macos.sh`).
  2. Run the (hopefully) platform-agnostic `setup.sh`.
  3. Optionally, run any platform-specific additional configuration (e.g. `macos-brew-extras.sh`).

Currently, the last step may take a large amount of time, but the other should be pretty quick.
