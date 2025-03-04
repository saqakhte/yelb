#!/bin/bash

# Massimo Re Ferre' massimo@it20.info

###########################################################
###########            CORE HOUSEKEEPING        ###########
###########################################################
export HOMEDIR="/yelb-setup"
apt-get update -y 
apt-get install -y git
if [ ! -d $HOMEDIR ]; then
    mkdir $HOMEDIR
    cd $HOMEDIR
    git clone http://github.com/saqakhte/yelb
fi 
###########################################################

apt-get install redis -y
sed -i "s/bind 127.0.0.1/bind 0.0.0.0/" /etc/redis/redis.conf
sed -i "s/protected-mode yes/protected-mode no/" /etc/redis/redis.conf
systemctl restart redis