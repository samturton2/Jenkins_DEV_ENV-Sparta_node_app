#!/bin/bash

sudo apt update
sudo apt install nginx -y

# import public key by package management system
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
# Create a list file for mongo
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt update
# Install MongoDB 3.2.20 and its packages
sudo apt install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -

# Make sure the bindIP is 0.0.0.0 using our manual copy of the config file
cd /Config_Folder
sudo cp -f mongod-copy.conf /etc/mongod.conf

# Start MongoDB
sudo service mongod start 

# Enable MongoDB
sudo systemctl restart mongod.service
sudo systemctl enable mongod.service --now
