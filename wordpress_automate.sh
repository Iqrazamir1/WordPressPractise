# #!/bin/bash 

# # Entering the html directory 
# cd /var/www/html

# # Installing the unzip package
# sudo apt -y install unzip 

# # Install/Unzip/Remove WordPress
# sudo wget https://wordpress.org/latest.zip 
# sudo unzip latest.zip  
# sudo rm latest.zip 

# # Generate password for use in WordPress Database
# username=$(tr -dc 'A-Za-z' < /dev/urandom | head -c 25)
# password=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 25)

# echo $username >> creds.txt
# echo $password > creds.txt

# # Create a MariaDB Database and a User for the WordPress Site  
# sudo mysql -e "CREATE DATABASE IF NOT EXISTS $username"
# sudo mysql -e "CREATE USER $username@localhost identified by '$password'"
# sudo mysql -e "GRANT ALL PRIVILEGES ON $username.* to $username@localhost"
# sudo mysql -e "FLUSH PRIVILEGES" # Applies everything you've done 

# sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
# sudo chmod 640 /var/www/html/wp-config.php 
# sudo chown -R www-data:www-data /var/www/html/wordpress

# sed -i "s/password_here/$password/g" /var/www/html/wp-config.php
# sed -i "s/username_here/$username/g" /var/www/html/wp-config.php
# sed -i "s/database_name_here/$username/g" /var/www/html/wp-config.php

############################################################################

#!/bin/bash 

# Entering the html directory 
cd /var/www/html

# Installing required packages
sudo apt -y install unzip awscli

# Install/Unzip/Remove WordPress
sudo wget https://wordpress.org/latest.zip 
sudo unzip latest.zip  
sudo rm latest.zip 

# Generate password for use in WordPress Database
username=$(tr -dc 'A-Za-z' < /dev/urandom | head -c 25)
password=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 25)

echo $username >> creds.txt
echo $password > creds.txt

# Download the database dump from S3
aws s3 cp s3://wordpress_dump.sql.gz/ /tmp/wordpress_dump.sql.gz

# Unzip the dump file
sudo gunzip /tmp/wordpress_dump.sql.gz 

# Create the database (if it doesn't already exist)
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $username"

# Restore the database from the dump file
sudo mysql $username < /tmp/wordpress_dump.sql

# Clean up the dump file
sudo rm /tmp/wordpress_dump.sql

# Set up the WordPress config file
sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo chmod 640 /var/www/html/wp-config.php 
sudo chown -R www-data:www-data /var/www/html/wordpress

# Update wp-config.php with the database credentials
sed -i "s/password_here/$password/g" /var/www/html/wp-config.php
sed -i "s/username_here/$username/g" /var/www/html/wp-config.php
sed -i "s/database_name_here/$username/g" /var/www/html/wp-config.php
