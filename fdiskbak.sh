#!/bin/bash

i=1  

while [ $i -lt 24 ]  
do  
j=`echo $i|awk '{printf "%c",97+$i}'`

fdisk /dev/sd$j << EOF 
d 
1   
n   
p  
1


w   
EOF

if [ $? != 0 ];then
   echo "*** Unable open /dev/sd${j}  complete was Fdisled! ***"
   exit 1
fi

 
echo "******/dev/sd${j} __was Fdisked! Waiting For 2 Second*****"  
mkdir -p /export/sd${j}
sleep 2  
                mkfs.ext4 /dev/sd${j}1  
                if [ "$?" = "0" ];then  
                    echo "*****sd${j}1 _was Formated, Waiting For 1 Second****" 
                fi  

                let i+=1  
		echo "/dev/sd${j}1               /export/sd${j}             ext4    defaults        0 0" >> /etc/fstab

sleep 1
 
done 
