#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y certbot
sudo apt install -y python3-certbot-nginx

# Define your email
EMAIL="zamiriqra0@outlook.com"
DOMAIN="certbot.paints-4-you.com"

# Use Certbot to obtain and install the SSL certificate
sudo certbot --nginx --non-interactive --agree-tos --email $EMAIL -d $DOMAIN

systemctl reload nginx

sudo bash /root/WordPressPractise/wordpress_automate.sh 
