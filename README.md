# backupmydata
Script to backup overgiven directory/file

Require following arguments : 

#Must write documentation
Script works as follow :
1. Import backup source from csv file/s (Implementation outstanding)
2. Check if directorys exist. Create if not
3. Copy source files/directorys to backuppath (default: /opt/backup) under date directory54. Compress directorys older than 1 day (Implementation outstanding)
5. Git update to master
6. Delete backups older than latedays (default:3)
Fixed Bugs :
- git version now working proberly.

Known Bugs :
- single files cant be handled. Have to fix this
- static backupdestination. Change to overgive argument or config in global conf file
- Debug level to split delivery stdout to terminal and file dont work right now.
