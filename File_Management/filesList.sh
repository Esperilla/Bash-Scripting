#!/bin/bash

show_help(){
    echo "File List"
    echo "This script lists files in a directory that contain all the words of the search string in their name."
    echo ""
    echo "Usage: $0 <directory> \"<search string>\""
    exit 1
}

test "$1" == "-h" || test "$1" == "--help" && { show_help; exit; }

#Validate that two parameters are received:
if [ "$#" -ne 2 ]; then
    echo "Error: Two parameters are needed: a directory and a search string."
    show_help
    exit 1
fi

directorio="$1"
string="$2"

#Validate that the first parameter is a directory:
if [ ! -d "$directorio" ]; then
    echo "Error: $directory is not a valid directory."
    exit 1
fi

#Convert the string into an array of words:
IFS=' ' read -r -a words <<< "$string"

#List of files
found_files=()

#Loop through the directory
for file in "$directory"/*; do
    if [ -f "$file" ]; then
        file_name="$(basename "$file")"
        for word in "${words[@]}"; do
            if echo "$file_name" | grep -qw "$word"; then
                found_files+=("$file_name")
                break
            fi
        done
    fi
done

#Show the found files
if [ "${#found_files[@]}" -eq 0 ]; then
    echo "No files found that match the search."
else
    echo "Found files:"
    printf "%s\n" "${found_files[@]}"
fi