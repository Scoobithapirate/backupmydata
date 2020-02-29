#!/bin/bash
#
#Perform daily backup of directory
# backupmydata 
date=$(date +%d_%m_%Y)
#Set the value how long to keep files in days.
olderthen=3
#Set the destination backup directory
backuppath=$(echo "/opt/backup/")
#Set the source directory/file
sourcepath=/etc/letsencrypt
#Get the program / directory name for abstraction
cd $sourcepath
backupdirectory=$(basename $(pwd))
#set debug for all commands
debug=&>> /var/log/debug_backup_${backupdirectory}.log 
#check if directorys exists, else create them first
for directory in $backupdirectory ${backuppath}$date ${backuppath}${date}/${backupdirectory}
do
    if [ -d $directory ]
    then
        echo "$directory already exists. skip create"$debug
    else
        echo "failed to find $directory. Create it now! "$debug
        mkdir $directory
    fi 
done
cd $backuppath
#Check if file exists. Overwrite or create then.
for file in $sourcepath/*; do 
    if [ -f $file ]
        then
            echo "$file exists. Overwrite!"  $debug
        else
            echo "$file none exist. Create!"$debug
    fi
    cp -av $file ${backuppath}${date}/${backupdirectory} ${debug}
done


#Delete all Backups older than $olderthen days
echo $olderthen
find $backuppath${date} -mtime +$olderthen -exec rm -rf {} \;$debug