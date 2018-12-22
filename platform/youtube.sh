#!/bin/bash

################################## 
rm -rf ../download/sslocal.log
sslocal -c ../download/config.json.txt !&> ../download/sslocal.log &
source ../config/privoxy_rc
n=0
grep -iq "starting" ../download/sslocal.log
while [[ $? = 1 ]]
do
	sleep 1s
	echo loop
	n=`expr $n + 1`
	echo $n
	if (( $n > 50 )); then
		echo sslocal_fail
		exit
	fi
	grep -iq "starting" ../download/sslocal.log
done
echo "sslocal starting succssefully!!"
#################################
dura_b=0
dura_e=1200
vdir="./"
log='../download/update.txt'
while getopts :i:b:e:d: OPTION;
do
    case $OPTION in
    i) homepage=$OPTARG
    ;; 
    b) dura_b="$OPTARG"
    ;; 
    e) dura_e="$OPTARG"
    ;; 
    d) vdir="$OPTARG"
    ;; 
    ?) echo "-i is need"
    ;; 
    esac
done
echo $homepage $dura_b $dura_e $vdir
wget $homepage -O tmp_youtube
dura_arr=`grep "aria-label=" tmp_youtube | grep "video-time" | sed 's/.*aria.*">\(.*\)<\/span><.*/\1/g'`
vurl_arr=`grep -i 'Queue" data-video-ids=' tmp_youtube | sed 's/.*eue" data-video-ids="\(.*\).*but.*/\1/g' | sed 's/".*//g'`
time_arr=`grep 'lockup-meta-info' tmp_youtube | sed 's/.*li><li>\(.*\)<\/li.*/\1/g' | sed 's/ /-/g'`
i=1
for dura in ${dura_arr}
do

	vurl=`echo $vurl_arr | cut -d' ' -f $i`
	time=`echo $time_arr | cut -d' ' -f $i`
	vid=`echo $vurl | sed 's/-/@/g' `
	minute=`echo $dura | cut -d':' -f 1` 
	second=`echo $dura | cut -d':' -f 2`
        second_dura=`expr $minute \* 60 + $second `	
	echo $vurl $vid $time

	grep -q "$vid" $log
	if [[ $? == 0 ]]; then
		echo noupdate
	elif (( "$second_dura" > "$dura_b" )) && (( "$second_dura" < "$dura_e" )); then
		echo -e "$time-----$dura-----------$vid" >> $log
		echo downloading
		./you-get https://www.youtube.com/watch?v="$vurl" -o $vdir
	else
		echo "duration is out of range"
		echo -e "$time-----$dura------$vurl" >> $log
	fi
	i=`expr $i + 1 `
done
#kill -9 `ps | sed -n '/sslocal/p' | awk '{print $1}'`
