#! /usr/bin/env bash 

# install & setup db
sudo apt-get install python-mysqldb libmysqlclient-dev
sudo mysql -u root -p
CREATE DATABASE catalog;
CREATE USER catalog_user IDENTIFIED BY 'anotherbadpass';
GRANT ALL PRIVILEGES ON catalog.* TO 'catalog_user'@'localhost' IDENTIFIED BY 'anotherbadpass';
