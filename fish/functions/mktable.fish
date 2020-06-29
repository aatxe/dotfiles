function mktable --description "produces a LaTeX table for oxide testing results"
    set -q argv[1]; or set argv[1] (pwd)

    echo "\begin{tabular}{*{21}{c|}c}"
    echo "\multicolumn{2}{c|}{in-scope} & \multicolumn{20}{c}{disqualified} \\\\ \hline"
    echo "borrowck & nll & advanced control flow & casting &
    first-class constructors & debug dump & enums & function mutability & heap &
    inline asm & out-of-scope library & macros & multithreading &
    slice patterns & statics \& constants & traits &
    two-phase borrows & uninitialized variables & universal function call &
    unsafe & variable mutability \\\\ \hline"

    echo -n (cat "$argv/tests/borrowck/results.json" | jq ".matches | length") " & "
    echo -n (math (cat "$argv/tests/nll/results.json" | jq ".matches | length") + \
                  (cat "$argv/tests/nll/closure-requirements/results.json" | jq ".matches | length") + \
                  (cat "$argv/tests/nll/relate_tys/results.json" | jq ".matches | length") + \
                  (cat "$argv/tests/nll/user-annotations/results.json" | jq ".matches | length"))

    for folder in (ls $argv/tests/disqualified)
        echo -n " &" (ls -1 $argv/tests/disqualified/$folder | wc -l | xargs)
    end
    echo " \\\\"

    echo "\end{tabular}"
end
