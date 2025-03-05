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

cd $HOMEDIR
sudo apt-get install postgresql postgresql-contrib
#service postgresql initdb
#the seds below relaxe the postgres configuration to allow remote connectivity. This trades off security best practices for sake of deployment simplicity
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/16/main/postgresql.conf
sudo sed -i "s/#port = 5432/port = 5432/" /etc/postgresql/16/main/postgresql.conf
sudo sed -i "s/peer/trust/" /etc/postgresql/16/main/pg_hba.conf
sudo sed -i "s/ident/trust/" /etc/postgresql/16/main/pg_hba.conf
sudo sed -i "s@host    all             all             127.0.0.1/32@host    all             all             0.0.0.0/0@" /etc/postgresql/16/main/pg_hba.conf

sudo systemctl restart postgresql
sudo -u postgres psql -v ON_ERROR_STOP=1 <<-EOSQL
    CREATE DATABASE yelbdatabase;
    \connect yelbdatabase;
		CREATE TABLE restaurants (
    	name        char(30),
    	count       integer,
    	PRIMARY KEY (name)
		);
		INSERT INTO restaurants (name, count) VALUES ('outback', 0);
		INSERT INTO restaurants (name, count) VALUES ('bucadibeppo', 0);
		INSERT INTO restaurants (name, count) VALUES ('chipotle', 0);
		INSERT INTO restaurants (name, count) VALUES ('ihop', 0);
EOSQL

sudo -u postgres psql -v ON_ERROR_STOP=1 <<-EOSQL
ALTER USER postgres WITH PASSWORD 'postgres';
EOSQL


