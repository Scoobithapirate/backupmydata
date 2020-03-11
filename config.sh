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