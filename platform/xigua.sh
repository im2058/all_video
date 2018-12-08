#!/bin/bash
url=$1
dir=$2
n=0
while [[ "$n" < 5 ]]
do
	../py_script/page_get.py $url video_html vjs_video_3_html5_api
	title=`grep 'utf-8"><title' video_html | sed 's/.*utf-8"><title>\(.*\)<\/title.*/\1/g'`
	videourl=`grep 'video/mp4' video_html | sed 's/.*video\/mp4" src="\(.*\)"><\/video.*/\1/g'`
	#echo $videourl
	grep -q "video/mp4" video_html
	if [[ "$?" < 1 ]]; then
		echo $videourl | grep -q "AWSAccessKeyId"
		if [[ "$?" > 0 ]]; then
		n=5
		fi
	fi
	echo $n
	n=`expr $n + 1`
done
### make sure get the right url
echo $videourl
aria2c $videourl\#mp4 -d $dir -o "$title".mp4 
