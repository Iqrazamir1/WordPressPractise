#!/bin/bash

# Update package list and insta;; Certbot and Cerbot nginx plugin
sudo apt update -y
sudo apy upgrade -y 
sudo apt install certbot python3-certbot-nginx -y

# Defining my email
EMAIL="zamiriqra0@outlook.com"

# Use Certbot to botain and install the SSL certificate
sudo certbot --nginx --non-interactive --agree-tos --email $EMAIL

# Nginx unit test that will reload nginx to apply changes only if the test is successful
sudo nginx -t && systemctl reload nginx