#!/bin/bash
for sr in `ls ../source`
do
	echo $sr
	a=`cat ../source/$sr`
	python ../py_script/kk.py  "$a" "$sr"
done
