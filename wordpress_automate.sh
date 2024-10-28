#!/bin/bash

# Install unzip Package 
sudo apt -y install unzip

# Install/Unzip/Remove WordPress 
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo rm latest.zip

# Create MariaDB Database
sudo mysql -e "CREATE DATABASE IF NOT EXISTS wordpress"
sudo mysql -e "CREATE USER IF NOT EXISTS wpuser@localhost identified by 'my_password'"
sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* to wpuser@localhost"
sudo mysql -e "FLUSH PRIVILEGES"

sudo wget -O https://iqrawordpressbucket.s3.eu-north-1.amazonaws.com/wp-config.php
sudo chmod 640 wp-config.php
sudo chown -R www.data:www-data
