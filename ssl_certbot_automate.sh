#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y certbot
sudo apt install -y python3-certbot-nginx
sudo certbot --nginx
systemctl reload nginx

sudo bash /root/WordPressPractise/wordpress_automate.sh 
