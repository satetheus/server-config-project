#! /usr/bin/env bash

# setup & set permissions for authorized keys
sudo mkdir /home/chris/.ssh && sudo touch /home/chris/.ssh/authorized_keys
sudo sed -i "\$a ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILMsIXqGZHeRoIpHVbWSbHkA6SO9zqv3hN05t10ah5E9 user@host" /home/chris/.ssh/authorized_keys 
sudo chmod 700 /home/chris/.ssh && sudo chmod 644 /home/chris/.ssh/authorized_keys

sudo mkdir /home/grader/.ssh && sudo touch /home/grader/.ssh/authorized_keys
sudo sed -i "\$a ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICLd9VUb4oo42+5FQoXTdEY3a7OfwsBIZTFM9NZCqq3g user@host" /home/grader/.ssh/authorized_keys 
sudo chmod 700 /home/grader/.ssh && sudo chmod 644 /home/grader/.ssh/authorized_keys

sudo chmod 777 /etc/ssh/sshd_config
    sudo sed -i "/PermitRootLogin/ c\PermitRootLogin no" /etc/ssh/sshd_config # disable root ssh login
    sudo sed -i "/PasswordAuthentication/ c\PasswordAuthentication no" /etc/ssh/sshd_config # disable password authenication (only keys)
    sudo sed -i "/Port 22/ c\Port 2222" /etc/ssh/sshd_config # change ssh port to 2222
    sudo sed -i "\$a AllowUsers chris grader" /etc/ssh/sshd_config # allow ssh from newly added users
sudo chmod 644 /etc/ssh/sshd_config
