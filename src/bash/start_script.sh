#!/usr/bin/bash
export USER="${USER:=`whoami`}"
export HOME=/home/$USER

#print user info
echo "$(id)"

export TORCH_HOME=/project/outputs/torch_home

# parse arguments
CMD=""
for i in $@; do
  if [[ $i == *"="* ]]; then
    ARG=${i//=/ }
    CMD=$CMD"--$ARG "
  else
    CMD=$CMD"$i "
  fi
done

# execute comand
echo $CMD
$CMD
