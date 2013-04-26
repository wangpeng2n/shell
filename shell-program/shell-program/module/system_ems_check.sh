#!/bin/sh
#set -x
. ../cfg/host.conf

_hostname=`hostname`
_osname=`uname`
_OutputSqlPath=$PROGRAM_HOME"/sql"

CreateSql()
{
  check_start_time=$(date +%Y-%m-%d" "%H:%M:%S)
  cpufilename="EMS_"$_hostname"_"`date +%Y%m%d%H%M%S`".sql"
  
$TIB_HOME/ems/bin/tibemsadmin -server tcp://$ems_servip:$ems_servport -ignore -user $ems_user -password $ems_pwd -script $PROGRAM_HOME/cfg/emsscript.cfg > /tmp/emsinfo.tmp
  conn=`cat /tmp/emsinfo.tmp | grep Connections: | awk '{print $2}' `
  pendmsg=`cat /tmp/emsinfo.tmp | grep "Pending Messages:" | awk '{print $3}'`
  pendsize=` cat /tmp/emsinfo.tmp | grep "Pending Message Size:" | awk '{print $4$5}'`
  produce=`cat /tmp/emsinfo.tmp | grep Producers: | awk '{print $2}' `
  consumer=`cat /tmp/emsinfo.tmp | grep Consumers: | awk '{print $2}'`
  memuse=` cat /tmp/emsinfo.tmp | grep "Message Memory Usage:" |  awk '{print $4$5}' `
  queues=` cat /tmp/emsinfo.tmp | grep Queues:  | awk '{print $2}' `

echo "alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'; " > $_OutputSqlPath/$cpufilename
sql=" INSERT INTO TAB_EMS_INFO (CHECK_START_TIME,CHECK_FREQUENCY,DOMAIN_NAME,EMS_CONNECTIONS,EMS_PENDING_MSG,EMS_PENDING_MSG_SIZE,EMS_PRODUCERS,EMS_CONSUMERS,EMS_MEMORY_USAGE,EMS_QUEUES) values('$check_start_time','$fre_ems min','$ems_domain',$conn,$pendmsg,'$pendsize',$produce,$consumer,'$memuse',$queues); "
echo $sql >> $_OutputSqlPath/$cpufilename



rm /tmp/emsinfo.tmp
}

CreateSql
