function cprepo --description "create a new git repo based off a github one"
  for name in $argv
    mkdir $GIT_SERVE_ROOT/$name.git
    pushd $GIT_SERVE_ROOT/$name.git
    git --bare init --shared
    git --bare fetch git@github.com:$GH_USERNAME/$name.git
    ln -s $HOME/.githooks/post-receive $GIT_SERVE_ROOT/$name.git/hooks/post-receive
    git remote add github git@github.com:$GH_USERNAME/$name.git
    git remote add gitlab git@gitlab.com:$GL_USERNAME/$name.git
    sudo chown -R git:git $GIT_SERVE_ROOT/$name.git
    popd
  end
end
