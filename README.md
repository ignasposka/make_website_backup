# make_website_backup :zap:
Backup script used to backup website files inside single linux machine.  
  
Let's figure out what actually script does under the hood :wrench:  
  
* `#!/bin/sh` - it's just a shell script header which informs interpreter that /bin/sh shell needs to be used to execute script.  
* `backups_capacity=10` - here we setting how many backups we want to preserve in the folder.  
* `if [ ! -d "/root/websites_backup" ]; then` - checking if /root/websites_backup directory not exist.  
`mkdir /root/websites_backup` - if it does not exist we creating it  
`mkdir /root/websites_backup/$1` - also creating website folder inside it  
`elif [ ! -d "/root/websites_backup/$1" ]; then` - otherwise we checking if directory /root/websites_backup has the folder of website  
`mkdir /root/websites_backup/$1` - if not, creating it  
`fi` - finishing conditional scope  
* `DATE=$(date '+%Y-%m-%d_%H:%M:%S')` - recording current date  
* `cp -r /var/www/$1 /root/websites_backup/$1/$DATE` - just copying files from `/var/www/$1` (from where our server serves webpage) to backup location `/root/websites_backup/$1/$DATE`. Folder `$DATE` are being created automatically by cp.  
* `number_to_delete=$(($(ls /root/websites_backup/$1 | wc -l) - $backups_capacity))` - here we are counting how many backups we should delete to preserve desired number of backups.  
* `if [ "$number_to_delete" -gt 0 ]; then` - first we are checking if we have what to delete.  
* `cd /root/websites_backup/$1` - if yes, we moving to backups directory
`ls -t /root/websites_backup/$1 | tail -n $number_to_delete | xargs -d '\n' rm -r` - sorting backups by modification time in descending order, passing to *tail* for separating oldest ones and using *xargs* utility to pass file names to delete one by one recursively by *rm* command.  
  
If you find any discrepancies, errors in readme or code, do not hesitate to make pull request or just reach out me with the comments. Your help is highly appreciated. ❤️

