###################                                                                         
#Andrii Kushlyk | andrii.k@opsworks.co
#05/04/2019
###################
#!/bin/sh
#MySQL Username
mysql_user="<-Type your mysql user->"
#MySql user password
mysql_pass="<-Type your mysql password->"
#MySql host if it another please change
mysql_host="localhost"
#Database to backup
mysql_db="<-Type your mysql database->"
#Get The current date/time
now="$(date +'%d_%m_%Y')"
#website_name
website="<-Type your name of website->"
#path to www catalog
www_dir="<-Type your path to www folder example: /var/www/html ->"
#folder to backup
file_dir="<-Type your name of the folder to backup example: wordpress "
#The folder to save the backups in
backupfolder="<-Type your path to backups folder example:/home/ubuntu/backup->"
#Set the backup filename with todays date/time
filename=${website}${now}.tar
#Temporary folder backup name
backupname=${website}${now}
#Temp path for database dump
temp_mysql=${mysql_db}.sql
#Path to the final backup
fullpathbackupfile="$backupfolder/$filename"
#Start MYSQL Dump
cd $backupfolder && mkdir $backupname && cd $backupname
echo "Starting mysql dump"
mysqldump --user=$mysql_user --password=$mysql_pass --host=$mysql_host $mysql_db > $temp_mysql
echo "Finished mysql dump, starting file dump"
#Archive all files in specified directory
cd $www_dir
cp -R $file_dir $backupfolder/$backupname 
echo "File Dump Finished, Adding DB And Files to a single archive"
#Add database dump and file dump to a archvie
cd $backupfolder
tar cvf $filename $backupname
rm -rf $backupname
echo "Done with archive, removing unneeded files"
#Remove temp temp files
echo "Backup finished. Your backup is located at "$fullpathbackupfile
