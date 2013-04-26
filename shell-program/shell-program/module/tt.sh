#!/bin/bash

if [ -z "$1" ]; then

  echo ""
  echo " ERROR : Invalid number of arguments"
  echo " Usage : $0 <date> <time>"
  echo ""
  exit
fi

LOGS=/shared/esb/applogs/core
for x in up-teller1 up-teller2 up-teller3 up-teller4 down-rb down-cl down-dp down-gl down-cd down-fm down-data up-data down-mm down-fx up-nv down-ft down-pi down-tf \
up-tf down-pg up-pg down-cdbcls up-cdbcls down-cdbwf up-wf up-summit up-dbank down-cdbibpinfo down-cdbsilinfo up-cdbibp up-cdbrt up-cdbsil downlog 
do
echo "================================================================"
if [ -d $LOGS/$x/log/$1 ]; then
	echo  "$1 $x Send and Rece is `cat $LOGS/$x/log/$1/Info.log |grep "MsgSend" |wc -l` \
`cat $LOGS/$x/log/$1/Info.log |grep "MsgRevd" |wc -l`" 
	else
	echo "$1 $x Send and Rece is" "     0        0"
fi
done
echo "================================================================"
