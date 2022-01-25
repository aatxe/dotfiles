function fish_prompt
	set -l __last_command_exit_status $status

    if not set -q -g __fish_robbyrussell_functions_defined
        set -g __fish_robbyrussell_functions_defined
        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)
            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD 2>/dev/null)
            end
        end

        function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty 2>/dev/null)
        end

        function _is_git_repo
            type -q git
            or return 1
            git status -s >/dev/null 2>/dev/null
        end

        function _hg_branch_name
            echo (hg branch 2>/dev/null)
        end

        function _is_hg_dirty
            echo (hg status -mard 2>/dev/null)
        end

        function _is_hg_repo
            type -q hg
            or return 1
            hg summary >/dev/null 2>/dev/null
        end

        function _repo_branch_name
            eval "_$argv[1]_branch_name"
        end

        function _is_repo_dirty
            eval "_is_$argv[1]_dirty"
        end

        function _repo_type
            if _is_hg_repo
                echo 'hg'
            else if _is_git_repo
                echo 'git'
            end
        end
    end

    set -l red (set_color -o red)
    set -l blue (set_color -o blue)
    set -l purple (set_color -o purple)
    set -l green (set_color -o green)
    set -l normal (set_color normal)

    set -l arrow_color "$green"
    if test $__last_command_exit_status != 0
        set arrow_color "$red"
    end

    set -l arrow "$arrow_color➜ "
    if test "$USER" = 'root'
        set arrow "$arrow_color# "
    end

    set -l cwd $purple(basename (prompt_pwd))$blue

    echo -n -s $arrow ' ' $blue '('$cwd')' $normal ' '
end
