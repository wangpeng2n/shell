#!/bin/bash 
./ssh_keygen.exp
server_list=$1
for line in `cat "$server_list"`
do
    ip=${line%,*}
    password=${line#*,}
    echo "ip=$ip password=$password"
    ./ssh_copyid.exp $ip $password
done
ssh-add /root/.ssh/id_rsa 

file=$2
destination=$3
for line in `cat "$server_list"`
do 
   ip=${line%,*}
   scp "$file" "$ip":"$3"
done

for line in `cat "$server_list"`
do
   ip=${line%,*}
   ./ssh_runscript.exp $ip $file $destination
done


exit 0
