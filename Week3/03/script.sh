#!/bin/bash
sleep 10
sudo apt-get -y update
sudo apt-get -y install apache2
sudo service apache2 start
echo "Provisioner Remote-exec" > /var/www/html/index.html