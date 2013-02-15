#!/bin/bash   

# sync options source destination
#rsync  wwsvrusr@108.174.144.140:/home/wwsvrusr/subdomains/test.strongchoices/db/strongchoices.sql ./

echo 'Init logging into server and dump database to tmp_strongchoices.sql.'
ssh wwsvrusr@108.174.144.140 "cd subdomains/test.strongchoices/db/; drush sql-dump > tmp_strongchoices.sql; ls -lah"

echo 'Init copying database file to current directory.'
scp wwsvrusr@108.174.144.140:/home/wwsvrusr/subdomains/test.strongchoices/db/tmp_strongchoices.sql ./

echo 'Importing database using Drush.'
$(drush sql-connect) < tmp_strongchoices.sql

echo 'Done!'

