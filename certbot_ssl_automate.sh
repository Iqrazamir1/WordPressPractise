#!/bin/bash

# Update package list and install Certbot and Certbot Nginx plugin
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y certbot python3-certbot-nginx

# Define your email
EMAIL="zamiriqra0@outlook.com"
DOMAIN="ec2-13-48-249-214.eu-north-1.compute.amazonaws.com"

# Use Certbot to obtain and install the SSL certificate
sudo certbot --nginx --non-interactive --agree-tos --email $EMAIL -d $DOMAIN

# Nginx unit test that will reload Nginx to apply changes ONLY if the test is successful
sudo nginx -t && systemctl reload nginx

# sudo bash /root/wordpress-project/wordpress-install.sh


####################################################

# Update package list and insta;; Certbot and Cerbot nginx plugin
#sudo apt update -y
#sudo apt upgrade -y 
#sudo apt install certbot python3-certbot-nginx -y

# Defining my email
#EMAIL="zamiriqra0@outlook.com"

# Use Certbot to botain and install the SSL certificate
#sudo certbot --nginx --non-interactive --agree-tos --email $EMAIL

# Nginx unit test that will reload nginx to apply changes only if the test is successful
#sudo nginx -t && systemctl reload nginx
