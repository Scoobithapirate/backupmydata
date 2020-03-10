#!/bin/bash
#
#Perform daily backup of directory
# backupmydata 
date=$(date +%d_%m_%Y)
#Set the value how long to keep files in days.
olderthen=3
#Set the destination backup directory
backuppath=$(echo "/opt/backup/")
#Set log path
logpath=$(echo "/var/log/backupmydata")
#Set the source directory/file
sourcepath=/etc/letsencrypt
#Get the program / directory name for abstraction
cd $sourcepath
backupdirectory=$(basename $(pwd))
#set debug for all commands
#check if directorys exists, else create them first
CreateDirectory(){
    #check if directory exists, otherwise create it
    #input : directory
    #output : none
    inDirectory=$1
    if [ -d $inDirectory ]
        then
            WriteMessageToLog "$inDirectory already exists. skip create"
        else
            
            mkdir $inDirectory

    fi 
}
gitInitRoutine(){
    inDirectory=$1
    cd $inDirectory
    git init 
    gitInitCommit 
    cd -
}
gitInitCommit(){
    #Overgive directory path and init new git repository
    #input : directorypath
    #output : none
    git add *
    gitUpdateCommit "git init"
}
gitUpdateCommit(){
    #Overgive inCommit message and let shell script update version in git master branch.
    #input : string
    #output : none
    inCommit=$1
    git add *
    git commit -a -m $1
}
CheckFileExists(){
    #check if file exists, and write log entrys.
    #input : file
    #output : none
    inFile=$1
    if [ -f $inFile ]
        then
            WriteMessageToLog "$inFile exists. Overwrite!" 
        else
            WriteMessageToLog "$inFile not exist. Create!"
    fi
}
WriteMessageToLog(){
    #Write overgiven string to LogFile
    #input : string
    #output : log entry in $logpath
    inMessage=$1
    debugLevel=$2
    if [ -z $2 ] 
    then
        #No logging.
        debugLevel=1
    fi
    case $debugLevel in
                1 )
                    #Debug. See all Messages in terminal session and get log file
                    echo $inMessage | tee {} >> $logpath/${date}/${backupdirectory}/debug.log
                ;;
                2 )
                    #Create logFile. Need for further analyse by remote.
                    echo $inMessage >> $logpath/${date}/${backupdirectory}/debug.log
                ;;
                7 ) 
                    #No logging. Direct to /dev/null
                    echo $inMessage >> /dev/null
                ;;


    esac
            #If no parameter overgiven set Logging to debug.
}
for directory in $backuppath $logpath ${backuppath}$date $logpath/${date} $logpath/${date}/${backupdirectory}  ${backuppath}${date}/${backupdirectory} 
do
    CreateDirectory $directory 
done
cd $backuppath
#Check if file exists. Overwrite or create then.
for file in $sourcepath/*; do 
    if [ -d $file ] 
        then
            CreateDirectory $file
        else
            CheckFileExists $file
            cp -a $file ${backuppath}${date}/${backupdirectory} ${debug}
        fi
done

#Delete all Backups older than $olderthen days
find $backuppath${date} -mtime +$olderthen -exec rm -rf {} \;$debug

#Update Version
if ! test -d $backuppath${date}/.git 
then
    gitInitRoutine $backuppath${date}
    cd $backuppath${date}
    gitUpdateCommit "$(date +%T)"
else
    cd $backuppath${date}
    gitUpdateCommit "$(date +%T)"
fi
