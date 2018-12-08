#!/bin/bash
###for xigua
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf_bak
sudo cp ./smb.conf /etc/samba/
sudo service smbd restart
sudo chmod -R 777 ../download
sudo chmod -R 777 ../source
sudo chmod 755 ../download/update.log
ma=`cat ../download/mail.txt`
sudo cp ../py_script/ip.pybak ../py_script/ip.py
sed -i "s/AA/$ma/g" ../py_script/ip.py
ipa=`ifconfig | grep "broadcast" | sed 's/inet\(.*\)netmas.*/\1/g'`
python ../py_script/ip.py "$ipa" "source_and_download dir"
#crontab -e 
#*/30 * * * * cd /home/pi/KK/xigua && bash xigua.sh > tmp/cron.log
#* 19 * * 5 cd /home/pi/KK/xigua/config && bash sendme.sh

usb=`ls /dev/sd* | grep "[0-9]"`
sudo mount -t ntfs -o umask=000 $usb /home/pi/KK/xigua/download
