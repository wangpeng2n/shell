#!/bin/sh
# set variable  
ip_mod=$1  
mask_mod=$2  
gw_mod=$3  
dns_mod=$4  
hostname_mod=$5  
 
hosts=/etc/hosts  
ifcfg=/etc/sysconfig/network-scripts/ifcfg-eth0  
network=/etc/sysconfig/network  
resolv=/etc/resolv.conf  
hwaddr=`grep -i HWADDR $ifcfg|awk -F "=" '{print $2}'`  
 
# mod ip、mask、gw、dns、hostname  
if [ $# != 5 ];then  
cat << EOF 
+-----------------------------------------------------------------------------------+  
++++++                                              +++++  
| ====   这是一个自动修改网络ip、掩码、网关、DNS、主机名的脚本                  ====|  
| ====   使用方法：ip_mod ip mask gw dns hostname                    ====|  
| ====   例：ip_mod 10.10.10.5 255.255.255.0 10.10.10.1 8.8.8.8 kerry           ====|  
++++++                                              +++++  
+-----------------------------------------------------------------------------------+  
EOF  
fi  
 
if [ $# == 5 ];then  
/bin/hostname $hostname_modf  
cp -r $hosts ${hosts}.bak  
echo -e "$ip_mod $hostname_mod" > $hosts  
 
cp -r $ifcfg ${ifcfg}.bak  
echo -ne "DEVICE=eth0 
BOOTPROTO=static 
HWADDR=$hwaddr  
IPADDR=$ip_mod  
NETMASK=$mask_mod  
ONBOOT=yes 
" > $ifcfg  
 
cp -r $network ${network}.bak  
echo -ne "NETWORKING=yes 
HOSTNAME=$hostname_mod  
GATEWAY=$gw_mod  
" > $network  
 
cp -r $resolv ${resolv}.bak  
echo -e "nameserver $dns_mod" > $resolv  
 
# restart network  
service network restart  
 
echo "ip、mask、gw、dns、hostname set OK .................!!!!!!!"  
fi  