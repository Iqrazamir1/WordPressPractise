#!/bin/bash

# Install Git 
sudo apt -y install git 
cd /root/
sudo git clone https://github.com/Iqrazamir1/WordPressPractise.git
sudo chmod -R 755 WordPressPractise
sudo bash WordPressPractise/lemp_stack_automate.sh
