#!/bin/bash

apt -y update && apt -y upgrade

apt install mariadb-server mariadb-client -y

sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

systemctl restart mariadb

password=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 25)
username=$(tr -dc 'A-Za-z' < /dev/urandom | head -c 25)

echo $password > creds.txt
echo $username >> creds.txt

# Create a new database for WordPress
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $username"
sudo mysql -e "CREATE USER $username@localhost identified by '$password'"
sudo mysql -e "GRANT ALL PRIVILEGES ON $username.* to $username@localhost"
sudo mysql -e "FLUSH PRIVILEGES" 

# Install the AWS CLI tool using Snap for managing AWS resources
snap install aws-cli --classic

# Upload the creds.txt file to the specified S3 bucket
# This securely stores the credentials file in AWS S3 for later use or backup
aws s3 cp creds.txt s3://saxtonator

# Instructions to Create an IAM Role for EC2:
# ===========================================

# 1. Go to the IAM Service in the AWS Management Console.
# 2. Create Role:
#    - Click on "Create role."
# 3. Select EC2 as the Trusted Entity:
#    - Under "Select trusted entity," choose "AWS Service."
#    - Under "Use case," select "EC2."
#    - Click "Next."
# 4. Attach Policies:
#    - Select a predefined policy like "AmazonS3FullAccess" for S3 access 
#      or create a custom policy with the permissions you need.
#    - Click "Next."
# 5. Name the Role:
#    - Provide a name (e.g., "EC2S3AccessRole").
#    - Click "Create role."
# 6. Attach the Role to Your EC2 Instance
#    - After confirming the role is properly created and associated with EC2:
#    - Go to the EC2 Dashboard.
#    - Select your instance and click Actions > Security > Modify IAM Role.
#    - The role should now appear in the dropdown menu.

# Note: The IAM Role can be attached to an EC2 instance for access to AWS services 
# (e.g., S3) without hardcoding credentials into your scripts.
