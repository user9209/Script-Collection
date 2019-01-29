#!/bin/bash

# sshfs
# apt-get install sshfs
if [ ! -d /mnt/atomServer/etc ]
then
  sshfs -p <port> -o ro root@<ip>:/ /mnt/atomServer
fi

# backup
# apt-get install rsync
src="etc opt Anpassungen var/www root home"

if [ "$1" == "data" ]
then
   # with data
   src="etc opt Anpassungen var/www root home data"
   echo "saving data"
fi

dateStart=`date '+%Y-%m-%d_%H-%M-%S'`

dest=/<target>/current
bkd=/<target>/history
logf=/<target>/log/log-$dateStart.txt

cd /mnt/atomServer

rsync -a -u -x -P --progress --partial -E -b --backup-dir=$bkd --log-file=$logf -h --stats --numeric-ids --delete $src $dest

dateEnd=`date '+%Y-%m-%d_%H-%M-%S'`
echo -e >> $logf "\nEnd: $dateEnd"
