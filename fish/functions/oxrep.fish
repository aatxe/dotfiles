function oxrep --description "produces a testing report from a results.json from the oxide test suite"
    echo "passing:" (cat $argv | jq ".matches | length")
    echo "failing:" (cat $argv | jq ".doesntmatch | length")
    echo "missing:" (cat $argv | jq ".missing | length")
    echo "ocaml error:" (cat $argv | jq ".typeerror | length")
    echo "reducer error:" (cat $argv | jq ".reducererror | length")
end
