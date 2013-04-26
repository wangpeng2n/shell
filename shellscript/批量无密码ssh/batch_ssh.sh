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

exit 0
