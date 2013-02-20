#!/bin/bash   

date +"%m_%d_%Y"

#You can store this to a variable name:

now=$(date +"%m_%d_%Y")

#OR

now=`date +"%m_%d_%Y"`

#Finally, you can create a filename as follows:

now=$(date +"%m_%d_%Y")
echo "Filename : /nas/backup_$now.sql"

#Sample outputs:
#Filename : /nas/backup_04_27_2010.sql
#You can create a shell script as follows:


_now=$(date +"%m_%d_%Y")
_file="/nas/backup_$_now.sql"
echo "Starting backup to $_file..."
# mysqldump -u admin -p'myPasswordHere' myDbNameHere > "$_file"]

echo $(data +%F)
# date