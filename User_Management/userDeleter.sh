#!/bin/bash

show_help(){
    echo "Delete User"
    echo "This script deletes a user from the system."
    echo ""
    echo "Usage: $0 <username>"
    
}

test "$1" == "-h" || test "$1" == "--help" && { show_help; exit; }

# Check if a username is provided
if [ $# -ne 1 ]; then
    show_help
    exit 1
fi

USER=$1

# Check if the user exists
if id "$USER" &>/dev/null; then
    echo "Deleting user: $USER"
    
    # Delete the user and its home directory
    userdel -r "$USER"
    
    if [ $? -eq 0 ]; then
        echo "User $USER deleted successfully."
    else
        echo "Error deleting user $USER."
    fi
else
    echo "User $USER does not exist."
fi