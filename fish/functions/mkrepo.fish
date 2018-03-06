function mkrepo --description "create a new git repo"
  for name in $argv
    mkdir /git/awe/$name.git
    pushd /git/awe/$name.git
    git --bare init --shared
    ln -s $HOME/.githooks/post-receive /git/awe/$name.git/hooks/post-receive
    git remote add github git@github.com:$GH_USERNAME/$name.git
    git remote add gitlab git@gitlab.com:$GL_USERNAME/$name.git
    sudo chown -R git:git /git/awe/$name.git
    popd
  end
end
