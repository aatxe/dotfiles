function sftp --description "sftp with rlwrap" --wraps=scp
  rlwrap /usr/bin/sftp $argv
end
