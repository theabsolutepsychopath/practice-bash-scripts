#!/bin/bash

#START OF SCRIPT
echo "Welcome to my testing script for copying entire directories of stuff!"
#ENTER DIRECTORY
echo "Please select the folder you would like to copy."
COPYFROM=$(zenity --file-selection --title="Select a directory to copy from." --directory)

case $? in
	0)
		echo "You selected \"$COPYFROM\" as the directory to copy from.";;
	1)
		echo "Please select the folder you would like to copy to."; exit;;
	-1)
		echo "Achievement Get: How did we get here? (An unexpected error has occured.)"; exit;;
esac
#ENTER DIRECTORY
echo "Please select the folder you would like to copy to."
COPYTO=$(zenity --file-selection --title="Select a directory to copy to." --directory)

case $! in
	0)
		echo "You selected \"$COPYTO\" as the directory to copy to.";;
	1)
		echo "Please select a directory to copy to."; exit;;
	-1)
		echo "Achievement Get: How did we get here? (An unexpected error has occured.)"; exit;;
esac
echo "We will now start moving over your files!"
sleep 3
#COPYING FILES
for file in "$COPYFROM"/*
do
FILEZ=$(echo $file | sed 's/.*\///')
FILERZ=$(echo $COPYTO | sed 's/.*\///')
echo "Moving $FILEZ to \"$COPYTO\""
mv -i "$file" "$COPYTO"
echo "Moved $FILEZ to \"$COPYTO\""
done
echo "Successfully moved all files from \"$COPYFROM\" to \"$COPYTO\""
exit
