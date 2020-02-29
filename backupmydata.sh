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
CreateDirectory(){
    #check if directory exists, otherwise create it
    #input : directory
    #output : none
    inDirectory=$1
    echo 
    if [ -d $inDirectory ]
        then
            WriteMessageToLog "$inDirectory already exists. skip create"
        else
            WriteMessageToLog "failed to find $inDirectory. Create it now! "
            mkdir $inDirectory
    fi 
}
CheckFileExists(){
    #check if file exists, and write log entrys
    inFile=$1
    if [ -f $inFile ]
        then
            WriteMessageToLog "$inFile exists. Overwrite!" 
        else
            WriteMessageToLog "$inFile not exist. Create!"
    fi
}
WriteMessageToLog(){
    inMessage=$1
    echo $inMessage$debug
}
for directory in $backupdirectory ${backuppath}$date ${backuppath}${date}/${backupdirectory}
do
    CreateDirectory $directory 
done
cd $backuppath
#Check if file exists. Overwrite or create then.
for file in $sourcepath/*; do 
    if [ -d $file ] 
        then
            echo "Directory $file found"
            CreateDirectory $file
        else
            CheckFileExists $file
            cp -a $file ${backuppath}${date}/${backupdirectory} ${debug}
        fi
done


#Delete all Backups older than $olderthen days
find $backuppath${date} -mtime +$olderthen -exec rm -rf {} \;$debug