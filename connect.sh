#!/bin/bash
########
#Created by anton 27.03.2024
########
#secure protocol rdp
#/sec:[rdp|tls|nla|ext]
#apt install freerdp2-x11
#apt install xvfb
ip_server=$1
user_server=$2
user_pass=$3
port_server=3389
status_f=/home/anton/script/status_start_rdp.txt
time_start=$(date -R)
#######check variable#######
if [ -z "$ip_server" ]; then
        echo No input ip server
        echo Usage: connect.sh 192.168.0.100 Username Password
        exit 1
fi
if [ -z "$user_server" ]; then
        echo No input username server
        echo Usage: connect.sh 192.168.0.100 Username Password
        exit 1
fi
if [ -z "$user_pass" ]; then
        echo No input password user server
        echo Usage: connect.sh 192.168.0.100 Username Password
        exit 1
fi
function rconnect() {
        echo Start process server:$ip_server of user: $user_server is:$time_start >> $status_f 
        xvfb-run xfreerdp /sec:rdp /cert-ignore /u:"$user_server" /p:"$user_pass" /v:"$ip_server:$port_server"
        }
function rclosed() {
        sleep 20
        killall xfreerdp
        exit
        }
rconnect & rclosed
exit
