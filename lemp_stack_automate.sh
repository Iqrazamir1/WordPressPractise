#!/bin/bash

# This file will contain the output of my LEMP Stack unit tests.
sudo touch /root/testing.txt

# Setup Nginx. Starts and enables nginx on a server reboot. The second command will only run if the first command is successful. 
sudo apt -y install nginx 
sudo systemctl start nginx && sudo systemctl enable nginx 
sudo systemctl status nginx > /root/testing.txt

# Install/Start MariaDB
sudo apt -y install mariadb-server
sudo systemctl start mariadb && sudo systemctl enable mariadb 
sudo systemctl status mariabd >> /root/testing.txt

# Install PHP 
sudo apt -y install php-fpm php php-cli php-common php-imap  php-snmp php-xml php-zip php-mbstring php-curl php-mysqli php-gd php-intl
sudo php -v >> /root/testing.txt

# Renaming apache testing page 
# sudo mv /var/www/html/index.html /var/www/html/index.html.old 

# Moving the nginx conf to the right location (downloading from git repo)
sudo mv /root/WordPressPractise/nginx.conf /etc/nginx/conf.d/nginx.conf

dns_record=$(curl -s icanhazip.com | sed 's/^/ec2-/; s/\./-/g; s/$/.compute-1.amazonaws.com/')
sed -i "s/SERVERNAME/$dns_record/g" /etc/nginx/conf.d/nginx.conf

# Disabling the defaut confug file 
sudo rm /etc/nginx/sites-enabled/default 

# This will only reload nginx if the test is successful 
nginx -t && systemctl reload nginx

sudo bash /root/WordPressPractise/wordpress_automate.sh  
