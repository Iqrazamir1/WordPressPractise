#!/bin/bash

cd /var/www/html

# Install the unzip package 
sudo apt -y install unzip 

# Install/Unzip/Remove WordPress 
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo rm latest.zip

# Create a MariaDB Database and a User for the WordPress Site  
sudo mysql -e "CREATE DATABASE IF NOT EXISTS wordpress"
sudo mysql -e "CREATE USER wpuser@localhost identified by 'my_password'"
sudo mysql -e "GRANT ALL PRIVILEGES ON wordpress.* to wpuser@localhost"
sudo mysql -e "FLUSH PRIVILEGES"

# Configure WordPress
cd wordpress/
cp wp-config-sample.php wp-config.php 

# S3 Bucket with the wp-config.pho file 

sudo chmod 640 wp-config.php 
