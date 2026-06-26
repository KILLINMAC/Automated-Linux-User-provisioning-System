#!/bin/bash

INPUT="users.csv"
LOG="logs/provisioning.log"
REPORT="reports/report.csv"

echo "username,group,permission,status" > $REPORT

while IFS=',' read -r username group password
do
    if [[ "$username" == "username" ]]; then
        continue
    fi

    echo "Processing user: $username"

    # 1. Create group if not exists
    if ! getent group "$group" > /dev/null; then
        groupadd "$group"
        echo "$(date) - Group $group created" >> $LOG
    fi

    # 2. Create user
    useradd -m -s /bin/bash -g "$group" "$username"

    # 3. Set password
    echo "$username:$password" | chpasswd

    # 4. Force password reset
    chage -d 0 "$username"

    HOME_DIR="/home/$username"

    # 5. Ownership
    chown -R "$username:$group" "$HOME_DIR"

    # 6. Apply group-based permissions 

    if [[ "$group" == "admin" ]]; then
        chmod 770 "$HOME_DIR"   # full access (rwx)
        PERM="770"
    elif [[ "$group" == "devops" ]]; then
        chmod 750 "$HOME_DIR"   # rwx for owner, r-x for group
        PERM="750"
    elif [[ "$group" == "testers" ]]; then
        chmod 550 "$HOME_DIR"   # r-x only
        PERM="550"
    else
        chmod 750 "$HOME_DIR"
        PERM="750"
    fi

    # 7. Extra safety: ensure group assignment
    usermod -aG "$group" "$username"

    # 8. Logging
    echo "$(date) - $username assigned to $group with permission $PERM" >> $LOG

    # 9. Report
    echo "$username,$group,$PERM,CREATED" >> $REPORT

done < $INPUT

echo "Provisioning Completed Successfully"
