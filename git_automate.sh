#!/bin/bash

# Updates all the latest security patches and software packages to ensure the highest level of security for my deployment.
sudo apt -y update 
sudo apt -y upgrade 

sudo apt -y install git 
cd /root/
sudo git clone https://github.com/Iqrazamir1/WordPressPractise.git
sudo chmod -R 755 /root/WordPressPractise
sudo bash /root/WordPressPractise/lemp_stack_automate.sh
