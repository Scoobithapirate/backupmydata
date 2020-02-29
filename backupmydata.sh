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
CreateDirectory()
{
    #check if directory exists, otherwise create it
    #input : directory
    #output : none
    inDirectory=$1
    echo 
    if [ -d $inDirectory ]
        then
            echo "$inDirectory already exists. skip create"$debug
        else
            echo "failed to find $inDirectory. Create it now! "$debug
            mkdir $inDirectory
    fi 
}
for directory in $backupdirectory ${backuppath}$date ${backuppath}${date}/${backupdirectory}
do
    CreateDirectory $directory 
done
cd $backuppath
#Check if file exists. Overwrite or create then.
for file in $sourcepath/*; do 
    if [ -f $file ]
        then
            echo "$file exists. Overwrite!"  $debug
        else
            echo "$file not exist. Create!"$debug
    fi
    cp -av $file ${backuppath}${date}/${backupdirectory} ${debug}
done


#Delete all Backups older than $olderthen days
find $backuppath${date} -mtime +$olderthen -exec rm -rf {} \;$debug