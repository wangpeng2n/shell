#!/bin/bash 
PARAM_LIST=$*
PARAM_NUM=$#
TOTAL_SIZE=0

for((i=0;i<$PARAM_NUM - 1;i++))
do
    [ ! -r $1 ] && echo "Cannot read $1." && exit 1
    SIZE=`du -s $1 | awk '{print $1}'`
    ((TOTAL_SIZE = $TOTAL_SIZE + $SIZE))
    shift
done

TARGET=$1
START_TIME=`date +%s.%N`
cp -a $PARAM_LIST &

while true
do
    COPIED=`du -s $TARGET | awk '{print $1}'`
    ((PERCENT = $COPIED * 100 / $TOTAL_SIZE))
    CURRENT_TIME=`date +%s.%N`
    MB_iSECOND=`echo $TOTAL_SIZE/1024/\($CURRENT_TIME-$START_TIME\)|bc`
    echo -ne "Total size: $TOTAL_SIZE KB - $PERCENT% - SPEED: $MB_iSECOND MB/s"
    STRING=`echo -ne "Total size: $TOTAL_SIZE KB - $PERCENT% - SPEED: $MB_iSECOND MB/s"`
    LEN_STRING=${#STRING}
    for((i=0;i<=$LEN_STRING;i++))
    do 
        echo -ne "\b"
    done 

    (($PERCENT == 100)) && END_TIME=`date +%s.%N` && break
done
MB_SECOND=`echo $TOTAL_SIZE/1024/\($END_TIME-$START_TIME\)|bc`
echo "Total size: $TOTAL_SIZE KB FINISHED - Avg.SPEED: $MB_SECOND MB/s"
exit














