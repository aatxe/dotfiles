function cat --description "mdcat for markdown files, cat for everything else"
  set cat_flags
  for arg in $argv
    if string match -rq -- '^-' $arg
      set cat_flags $cat_flags $arg
    end
    if string match -rq -- '.md$' $arg
      set cat_mdcat_args $cat_mdcat_args $arg
    else
      set cat_cat_args $cat_cat_args $arg
    end
  end
  if set -q cat_mdcat_args
    command mdcat $cat_flags $cat_mdcat_args
  end
  if set -q cat_cat_args
    command cat $cat_flags $cat_cat_args
  end
end
