#!/usr/bin/env fish

function run --description "Runs our Python build script."
  python3 $RUNSCRIPTS/run.py $argv
end
