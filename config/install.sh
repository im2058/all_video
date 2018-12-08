#!/bin/bash
#for youtube

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y shadowsocks privoxy 
###for xigua
sudo apt-get install -y vim tmux samba phantomjs python3-selenium
sudo apt-get install -y python3-dev build-essential libssl-dev libffi-dev libxml2 libxml2-dev libxslt1-dev zlib1g-dev libcurl4-openssl-dev
sudo apt-get install -y python3 python3-pip aria2 ntfs-3g
sudo pip3 install pyquery
sudo rm -f /usr/bin/python
sudo ln -s /usr/bin/python3.5 /usr/bin/python

