#! /usr/bin/env bash

# update system packages
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get autoremove -y

# create users chris & grader
sudo adduser --disabled-password --gecos "" chris --quiet
sudo adduser --disabled-password --gecos "" grader --quiet

# required password setup at first login
# sudo passwd -e chris
# sudo passwd -e grader

# add sudo capability to new users
sudo usermod -aG chris
sudo usermod -aG grader

# setup & set permissions for authorized keys
sudo mkdir /.ssh && sudo touch /.ssh/authorized_keys
sudo chmod 777 .ssh && sudo chmod 777 /.ssh/authorized_keys
sudo sed -i "\$a ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILMsIXqGZHeRoIpHVbWSbHkA6SO9zqv3hN05t10ah5E9 user@host" /.ssh/authorized_keys 
sudo sed -i "\$a ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICLd9VUb4oo42+5FQoXTdEY3a7OfwsBIZTFM9NZCqq3g user@host" /.ssh/authorized_keys 
sudo chmod 700 .ssh && sudo chmod 644 /.ssh/authorized_keys

# set firewall defaults
ufw default deny incoming
ufw default allow outgoing

# allow ssh
ufw allow ssh
ufw allow 2222/tcp

# allow web connections
ufw allow www

# turn on firewall
ufw --force enable

sudo chmod 777 /etc/ssh/sshd_config
    sudo sed -i "/PermitRootLogin/ c\PermitRootLogin no" /etc/ssh/sshd_config # disable root ssh login
    sudo sed -i "/PasswordAuthentication/ c\PasswordAuthentication no" /etc/ssh/sshd_config # disable password authenication (only keys)
    sudo sed -i "/Port 22/ c\Port 2222" /etc/ssh/sshd_config # change ssh port to 2222
    sudo sed -i "\$a AllowUsers chris grader" /etc/ssh/sshd_config # allow ssh from newly added users
sudo chmod 644 /etc/ssh/sshd_config

# install apache
sudo apt-get install apache2 apache2-bin -y

# install mod-wsgi
sudo apt-get install libapache2-mod-wsgi -y

# download catalog project
sudo git clone https://github.com/satetheus/CatalogProject /var/www/html/catalog

# configure apache for mod-wsgi
sudo sed -i "/^<\/VirtualHost>/i WSGIScriptAlias \/ \/var\/www\/html\/catalog\/views.py/" /etc/apache2/sites-enabled/000-default.conf

# restart apache
sudo apache2ctl restart

# restart ssh
sudo service ssh restart

# restart vm
sudo reboot