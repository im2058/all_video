sudo apt-get install -y shc
basedir=`pwd`
for sr in `ls ../platform | grep "sh"`
do

	cd ../platform
	shc -e 7/30/2019 -m "need to update" -vr -f $sr
	nm=`echo $sr | cut -d'.' -f 1`
	mv $sr.x $nm.sh
	cd $basedir
done
rm -rf ../platform/*.sh.x.c
