# Automated Linux User Provisioning System

## Overview

The Automated Linux User Provisioning System is a Bash-based automation project that simplifies Linux user account management. It provisions user accounts from a CSV file, assigns users to groups, applies role-based permissions, generates audit logs, and creates provisioning reports.

This project was developed and tested on an Ubuntu EC2 instance hosted on AWS.

---

## Features

- Automated Linux user creation
- Automatic group creation
- Group assignment
- Role-Based Access Control (RBAC)
- Password configuration
- Force password change on first login
- Home directory creation
- Permission management
- Provisioning logs
- CSV report generation

---

## Technologies Used

- Linux (Ubuntu 22.04)
- Bash Shell Scripting
- AWS EC2
- Git & GitHub

---

## Project Structure

```
linux-user-provisioning-system/
│
├── provision.sh
├── users.csv
├── logs/
│   └── provisioning.log
├── reports/
│   └── report.csv
└── README.md
```

---

## Role-Based Permissions

| Group | Permission | chmod |
|--------|------------|-------|
| admin | Full access | 770 |
| devops | Read, Write, Execute (owner); Read & Execute (group) | 750 |
| testers | Read & Execute | 550 |

---

## Input File

Example `users.csv`

```csv
username,group,password
Label,admin,Label@123
JD,devops,JD@123
Covid,testers,Covid@123
```

---

## How to Run

Clone the repository.

```bash
git clone https://github.com/your-username/linux-user-provisioning-system.git
```

Go into the project directory.

```bash
cd linux-user-provisioning-system
```

Give execute permission.

```bash
chmod +x provision.sh
```

Run the script.

```bash
sudo ./provision.sh
```

---

## Output

After execution, the script:

- Creates Linux users
- Creates required groups
- Assigns users to groups
- Configures permissions
- Creates home directories
- Generates logs
- Generates a provisioning report

---

## Generated Files

### Log File

```
logs/provisioning.log
```

### Report

```
reports/report.csv
```

---

## Future Enhancements

- LDAP integration
- Menu-driven interface
- User deletion
- User lock/unlock
- Password policy enforcement
- Email notification
- Ansible automation

---

## Author

Siddhant Waghmare
