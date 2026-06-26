# User Management

This directory contains a collection of Bash scripts designed to automate and simplify common user administration and file management tasks on Linux systems.

## Prerequisites

To run most of these scripts, you will need:

- A Unix/Linux environment with the **Bash** shell.
- Superuser privileges (**root** or `sudo`) for user management tasks.
- The `openssl` utility installed (used to generate random passwords).

---

## Directory Contents

The following scripts are included in this directory:

### 1. `userAdd.sh`

This script allows you to create a new user interactively, assigning them a securely generated random password and forcing a password change on their first login.

- **Requirement:** Must be executed with root privileges (`sudo`).
- **Usage:**
    ```bash
    sudo ./userAdd.sh
    ```
- **How it works:**
    1. Checks whether the script is being executed as the superuser.
    2. Prompts the administrator to enter the new username.
    3. Verifies whether the user already exists on the system.
    4. Creates the user with a home directory (`-m`) and sets `/bin/bash` as the default shell.
    5. Generates a 12-character random password using `openssl`.
    6. Forces the password to expire immediately (`passwd -e`), requiring the user to change it upon their first login.

### 2. `userDeleter.sh`

This script automates the complete removal of a user from the system, including their home directory.

- **Requirement:** Must be executed with root privileges (`sudo`).
- **Usage:**
    ```bash
    sudo ./userDeleter.sh <username>
    ```
- **How it works:**
    1. Verifies that exactly one argument (the username) has been provided.
    2. Checks whether the specified user exists on the system.
    3. If the user exists, removes both the user account and their home directory using `userdel -r`.
    4. Displays a success message or an error message if the operation fails.

### 3. `userDate.sh`

This utility script copies a file to a destination directory, appends the current date to the destination filename, and inserts the name of the user executing the script as the first line of the copied file.

- **Usage:**
    ```bash
    ./userDate.sh <source_file> <destination_directory>
    ```
- **How it works:**
    1. Creates the destination filename by appending the current date in the `YY-MM-DD` format.
    2. Copies the original file to the destination.
    3. Replaces the first line of the copied file with the current username (`whoami`).
    4. Appends the original file contents below the inserted username.

---

## Running the Scripts

Before using the scripts, make sure they have execution permissions:

```bash
chmod +x *.sh
```

To display the help message for any script, use the `-h` or `--help` option. For example:

```bash
./userDeleter.sh --help
```