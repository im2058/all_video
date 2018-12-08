#!/bin/bash

################################## 
source ../config/privoxy_rc
sslocal -c ../download/config.json.txt &  >> ../download/sslocal.log &
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
vurl_arr=`grep -i 'Queue" data-video-ids=' tmp_youtube | sed 's/.*Queue" data-video-ids="\(.*\)" data.*/\1/g'`
time_arr=`grep 'lockup-meta-info' tmp_youtube | sed 's/.*li><li>\(.*\)<\/li.*/\1/g' | sed 's/ /-/g'`
i=1
for dura in ${dura_arr}
do

	vurl=`echo $vurl_arr | cut -d' ' -f $i`
	time=`echo $time_arr | cut -d' ' -f $i`
	vid=`echo $vurl`
	minute=`echo $dura | cut -d':' -f 1` 
	second=`echo $dura | cut -d':' -f 2`
        second_dura=`expr $minute \* 60 + $second `	
	echo $vurl $vid $time

	grep -q "$vid" $log
	if [[ $? == 0 ]]; then
		echo noupdate
	elif (( "$second_dura" > "$dura_b" )) && (( "$second_dura" < "$dura_e" )); then
		echo -e "$time-----$dura------$vurl" >> $log
		echo downloading
		./you-get https://www.youtube.com/watch?v="$vid" -o $vdir
	fi
	i=`expr $i + 1 `
done

