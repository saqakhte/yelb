#!/bin/bash

# Massimo Re Ferre' massimo@it20.info

###########################################################
###########              USER INPUTS            ###########
###########################################################
# Variables AppServer component 
export RACK_ENV="${RACK_ENV:-custom}"
export REDIS_SERVER_ENDPOINT="${REDIS_SERVER_ENDPOINT:-localhost}"
export YELB_DB_SERVER_ENDPOINT="${YELB_DB_SERVER_ENDPOINT:-localhost}"
# If you want to connect to DDB you need to:
# set $YELB_DDB_RESTAURANTS / $YELB_DDB_CACHE / $AWS_REGION instead of $YELB_DB_SERVER_ENDPOINT / $REDIS_SERVER_ENDPOINT
###########################################################
###########           END OF USER INPUTS        ###########
###########################################################

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

echo "RACK_ENV = " $RACK_ENV
echo "REDIS_SERVER_ENDPOINT = " $REDIS_SERVER_ENDPOINT
echo "YELB_DB_SERVER_ENDPOINT = " $YELB_DB_SERVER_ENDPOINT
echo "YELB_DDB_RESTAURANTS = " $YELB_DDB_RESTAURANTS
echo "YELB_DDB_CACHE = " $YELB_DDB_CACHE
echo "AWS_REGION = " $AWS_REGION

cd $HOMEDIR
sudo apt-get update 

sudo apt-get install -y postgresql postgresql-contrib libpq-dev
sudo apt-get install -y ruby
sudo apt-get install -y gcc
#sudo apt-get install -y postgresql-devel
sudo gem install pg -v 1.5.9 --no-document
sudo gem install redis --no-document
sudo gem install sinatra --no-document
sudo gem install aws-sdk-dynamodb --no-document
cd ./yelb/yelb-appserver
ruby yelb-appserver.rb -o 0.0.0.0 & 

