#!/bin/bash

# Sample result:
#
## d1=.
## d2=/home/user
## d3=/home/user


# relative path
dir1=`dirname $0`

# absolute path
dir2=`dirname $(realpath $0)`
dir3="$( cd "$(dirname "$0")" ; pwd -P )"

echo -e "d1=$dir1\nd2=$dir2\nd3=$dir3"
