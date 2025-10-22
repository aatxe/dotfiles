#!/usr/bin/env fish

function build --description "Runs our Python build script."
  python3 $RUNSCRIPTS/build.py $argv
end
