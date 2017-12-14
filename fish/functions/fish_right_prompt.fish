function fish_right_prompt
  set -l yellow (set_color -o yellow)
  set -l purple (set_color -o purple)
  set -l blue (set_color -o blue)
  set -l normal (set_color normal)

  set -l repo_type (_repo_type)
  if [ $repo_type ]
    set -l repo_branch $purple(_repo_branch_name $repo_type)
    set repo_info "$blue $repo_type:($repo_branch$blue)"

    if [ (_is_repo_dirty $repo_type) ]
      set -l dirty "$yellow ✗"
      set repo_info "$repo_info$dirty"
    else
      set repo_info "$repo_info  "
    end
  end

  echo -n -s $repo_info $normal
end
