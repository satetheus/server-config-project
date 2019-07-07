#! /usr/bin/env bash

# update system packages
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get autoremove -y

# install apache & mod-wsgi
sudo apt-get install apache2 apache2-bin libapache2-mod-wsgi-py3 python3-pip -y

# download catalog project & setup project
sudo git clone https://github.com/satetheus/CatalogProject /var/www/html/catalog
sudo python3 -m pip install -r /var/www/html/catalog/requirements.txt

# restart apache
sudo apache2ctl restart

# restart ssh
sudo service ssh restart

# restart vm
sudo reboot