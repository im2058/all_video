#!/bin/bash
dura_b=0
dura_e=240
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
wget $homepage -O tmp_tencent
dura_arr=`grep "mask_txt" tmp_tencent | grep [0-9] | sed 's/.*mask_txt">\(.*\)<\/em>.*/\1/g'`
vurl_arr=`grep '.html" title=' tmp_tencent | sed 's/.*href="\(.*\)"\stitle=.*/\1/g'`
time_arr=`grep 'figure_info_time' tmp_tencent | grep [0-9] | sed 's/.*figure_info_time">\(.*\)<\/spa.*/\1/g'`
i=1
for dura in ${dura_arr}
do

	vurl=`echo $vurl_arr | cut -d' ' -f $i`
	time=`echo $time_arr | cut -d' ' -f $i`
	vid=`echo $vurl | cut -d'/' -f 3- `
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
		./you-get $vurl -o $vdir
	else
		echo "duration is out of range"
		echo -e "$time-----$dura------$vurl" >> $log
	fi
	i=`expr $i + 1 `
done

