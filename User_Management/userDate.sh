#!/bin/bash

show_help(){
    echo "File Copy with Date"
    echo "This script copies a file to a destination directory and adds the date to the filename."
    echo ""
    echo "Usage: $0 <source_file> <destination_directory>"
    
}

test "$1" == "-h" || test "$1" == "--help" && { show_help; exit; }

SOURCE_FILE="$1"
DESTINATION_DIRECTORY="$2"

#File name
FILE_NAME=$(basename "$SOURCE_FILE$(date +%y-%m-%d)")

#Complete destination path
DESTINATION_PATH="$DESTINATION_DIRECTORY/$FILE_NAME"

#Copy the file
cp "$SOURCE_FILE" "$DESTINATION_PATH"
whoami >> $DESTINATION_PATH
cat $SOURCE_FILE >> $DESTINATION_PATH

echo "File copied successfully to $DESTINATION_PATH"