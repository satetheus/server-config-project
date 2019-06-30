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

# add sudo capability to users
sudo touch /etc/sudoers.d/chris
sudo sed -i 'vagrant ALL=(ALL) NOPASSWD:ALL' /etc/sudoers.d/chris
sudo touch /etc/sudoers.d/grader
sudo sed -i 'vagrant ALL=(ALL) NOPASSWD:ALL' /etc/sudoers.d/grader

# setup & set permissions for authorized keys
sudo mkdir /.ssh && sudo touch /.ssh/authorized_keys
sudo sed -i '$a {add user chris public key}' /.ssh/authorized_keys 
sudo sed -i '$a {add user grader public key}' /.ssh/authorized_keys 
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
ufw enable -y

# disable root ssh login
sudo sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config

# disable password authenication (only keys)
sudo sed -i '/^PasswordAuthentication/s/yes/no/' /etc/ssh/sshd_config

# change ssh port to 2222
sudo sed -i '/^Port/s/22/2222/' /etc/ssh/sshd_config

# allow ssh from newly added users
sudo sed -i '$a AllowUsers chris grader' /etc/ssh/sshd_config

# restart ssh
sudo service ssh restart

# install apache
sudo apt-get install apache2

# install mod-wsgi
sudo apt-get install libapache2-mod-wsgi

# configure apache for mod-wsgi
sudo sed '/^<\/VirtualHost>/i WSGIScriptAlias \/ \/var\/var\/www\/html\/myapp.wsgi/' /etc/apache2/sites-enabled/000-default.conf