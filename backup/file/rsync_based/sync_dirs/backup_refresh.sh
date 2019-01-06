#!/bin/bash

# dir to being backuped (is not backuped itself!)
source_dir=/mnt/server_sshfs

# list of sub dirs in the source dir
dirs_to_backup="etc home opt root var/www"

# absolute path
target_dir=`dirname $(realpath $0)`/server_1to1copy
target_dir_old_files=`dirname $(realpath $0)`/server_1to1copy_history

# is the source dir valid
if [ ! -d "$source_dir" ]
  echo -e "Source-Dir $source_dir does not exists!\nExit now ..."
  exit 1

fi

# check dirs have to be created
if [ ! -d "$target_dir" ]
  mkdir -p "$target_dir"
fi

if [ ! -d "$target_dir_old_files" ]
  mkdir -p "$target_dir_old_files"
fi

# switch to source dir
cd "$source_dir"

# backup process
# optional add: -P --progress --partial
rsync -r -l -p -t -g -o -q -u -x \
 --delete -b --backup-dir="$target_dir_old_files" \
 -h --stats \
 $dirs_to_backup "$target_dir"

exit $?
