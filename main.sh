#!/bin/bash
basedir=`pwd`
src=$basedir/'source'
plat=$basedir/'platform'
downdir=$basedir/'download'
for txt in `ls $src`
do
	while read line
	do
	homeurl=`echo $line | cut -d' ' -f 1`
	bt=`echo $line | cut -d' ' -f 2`
	et=`echo $line | cut -d' ' -f 3`
	echo $homeurl
	if [[ `echo $homeurl | grep -q "qq.com" && echo $? ` = 0 ]]; then
		echo tencent && mkdir -p $downdir/$txt && cd $plat && ./tencent.sh -i $homeurl -b $bt -e $et -d $downdir/$txt
	elif [[ `echo $homeurl | grep -q "xigua" && echo $? ` = 0 ]]; then
		echo "xigua $basedir"   && mkdir -p $downdir/$txt && cd $plat && ./toutiao.sh -i $homeurl -b $bt -e $et -d $downdir/$txt
	elif [[ `echo $homeurl | grep -q "youtube" && echo $? ` = 0 ]]; then
		echo "Youtube"   && mkdir -p $downdir/$txt && cd $plat && ./youtube.sh -i $homeurl -b $bt -e $et -d $downdir/$txt
	fi												
	done < $src/$txt
done
rm -rf $plat/tmp_*
rm -rf $plat/video_html
kill -9 `ps | sed -n '/sslocal/p' | awk '{print $1}'`

