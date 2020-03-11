# backupmydata
Script to backup overgiven directory/file

Require following arguments : 


Script works as follow :
1. Overgive filepath as argument (max 1)
2. Check if directorys exist. Create if not
3. Copy source files/directorys to backuppath (default: /opt/backup) under date directory54. Compress directorys older than 1 day (Implementation outstanding)
5. Git update to master
6. Delete backups older than latedays (default:3)

#How to use
1. Clone git to local.
2. Leave default variables or change them.
3. Overgive path as argument

#Example use
- Use the script in combination with a crontab to backup important files every hour.
- Initial backup whole directory after finish fresh installation for recovery.

