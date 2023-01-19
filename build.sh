#!/usr/bin/env bash

CDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
build_dir=$CDIR/build

while getopts A:K:q option
do
  case "${option}"
  in
    q) QUIET=1;;
    A) ARCH=${OPTARG};;
    K) KERNEL=${OPTARG};;
  esac
done

cd $CDIR
rm -rf $build_dir && mkdir -p $build_dir

configdir="$HOME/.xxh/.xxh/config/xxh-plugin-prerun-dotfiles-conf"
homedir="$configdir/home"

for f in *prerun.sh "$homedir"
do
    cp -R $f $build_dir/
done

pip_requirements_file="$configdir/pip-requirements.txt"

pip_command="$(command -v pip)"

if [ -z "$pip_command" ]; then
  pip_command="$(command -v pip3)"
fi

if [ -x "$(command -v "$pip_command")" -a -f "$pip_requirements_file" ]; then

  PYTHONUSERBASE=$build_dir/home/.local "$pip_command" install --user -I -r "$pip_requirements_file"

  # Fix python shebang
  pypath=`readlink -f $(which python)`
  if [ -d "$build_dir/home/.local/bin" ]; then
    echo 'Fix PyPi packages shebang'
    sed -i '1s|#!'$pypath'|#!/usr/bin/env python|' $build_dir/home/.local/bin/*
  fi

else
  echo 'Skip pip packages installation: pip not found.'
fi
