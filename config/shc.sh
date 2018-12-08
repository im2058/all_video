sudo apt-get install -y shc

cd ../
shc -e 5/30/2019 -m "update" -vr -f down.sh
rm -rf down.sh down.sh.x.c
mv down.sh.x down.sh
