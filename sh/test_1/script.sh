#!/bin/bash

# while loop ignores the last line
while read servername ; do

	echo "$servername"
	
	echo $(ssh quan@$servername <<-EOF		
		echo "creative" | sudo -S syslog-ng -V
		echo 'Latest change: '
		ls -l -t /var/log/ | head -4
		exit
	EOF) > local.txt
	
	echo ''
	echo 'Version: '
	grep -o 'syslog-ng [0-9]\{0,1\}\.[0-9]\{0,3\}\.[0-9]\{0,3\}' local.txt
	
	echo 
	grep -o 'Latest change: .*' local.txt

done < server_list.txt
