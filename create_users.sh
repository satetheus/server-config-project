#! /usr/bin/env bash

# make user chris with sudo capability
sudo adduser --disabled-password --gecos "" chris --quiet
# sudo passwd -e chris
sudo usermod -aG sudo chris
sudo chown -R chris:chris /home/chris
sudo chown root:root /home/chris

# make user grader with sudo capability
sudo adduser --disabled-password --gecos "" grader --quiet
# sudo passwd -e grader
sudo usermod -aG sudo grader
sudo chown -R grader:grader /home/grader
sudo chown root:root /home/grader