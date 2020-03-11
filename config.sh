#!/bin/bash
#Perform daily backup of directory
# backupmydata 
date="date +%d_%m_%Y"
#Set the value how long to keep files in days.
olderthen=3
#Set the destination backup directory
backuppath="/opt/backup/"
#Set log path
logpath="/var/log/backupmydata"
#Set the source directory/file
sourcepath=/etc/letsencrypt