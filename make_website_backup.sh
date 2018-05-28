#!/bin/sh
backups_capacity=10
if [ ! -d "/root/websites_backup" ]; then
mkdir /root/websites_backup
mkdir /root/websites_backup/$1
elif [ ! -d "/root/websites_backup/$1" ]; then
  mkdir /root/websites_backup/$1
fi
DATE=`date '+%Y-%m-%d_%H:%M:%S'`
cp -r /var/www/$1 /root/websites_backup/$1/$DATE

number_to_delete=$((`ls /root/websites_backup/$1 | wc -l` - $backups_capacity
if [ "$number_to_delete" -gt 0 ]; then
cd /root/websites_backup/$1
ls -t /root/websites_backup/$1 | tail -n $number_to_delete | xargs -d '\n' r$
fi
