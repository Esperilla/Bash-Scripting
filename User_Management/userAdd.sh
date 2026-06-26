#!/bin/bash

show_help(){
    echo "User Creator"
    echo "This script creates a new user in the system with a random password."
    echo ""
    echo "Usage: $0 <username>"
}

test "$1" == "-h" || test "$1" == "--help" && { show_help; exit; }

# Check if the script is executed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be executed as root" 
   exit 1
fi

# Ask for the username
echo -n "Enter the username: "
read USERNAME

# Check if the user already exists
if id "$USERNAME" &>/dev/null; then
    echo "User '$USERNAME' already exists."
    exit 1
fi

# Create the user
useradd -m -s /bin/bash "$USERNAME"
if [[ $? -ne 0 ]]; then
    echo "Error creating the user."
    exit 1
fi

# Generate a random password
PASSWORD=$(openssl rand -base64 12)
echo "$USERNAME:$PASSWORD" | chpasswd

# Show the account information
echo "User created successfully."
echo "Username: $USERNAME"
echo "Password: $PASSWORD"

echo "It is recommended to change the password on the first login."
passwd -e "$USERNAME"

exit 0