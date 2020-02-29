#!/bin/bash
#
#Perform daily backup of directory
date=$(date +%d_%m_%Y)
olderthen=3
backuppath=$(echo "/opt/backup/")
sourcepath=/etc/letsencrypt
#Get the program / directory name for abstraction
cd $sourcepath
backupdirectory=$(basename $(pwd))
#set debug for all commands
debug=&>> /var/log/debug_backup_${backupdirectory}.log 
cd $backuppath
mkdir ${backuppath}${backupdirectory}_$date$debug
cp -av ${sourcepath}/* ${backuppath}${backupdirectory}_${date} ${debug}


#Delete all Backups older than $olderthen days
echo $olderthen
find $backuppath${backupdirectory}_* -mtime +$olderthen -exec rm -rf {} \;$debug