#!/bin/bash   

# Read in the text file by line
FILE='missing_videos.txt'

for line in $(< $FILE)
do 
	echo "---------------------------------------------------------------------------"	
	echo "Looking for :: $line"
	ls ../../DVD/Myprime_adapt_course/video/ | grep "$line*"
	
done