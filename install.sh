#!/usr/bin/env bash

# variables
APP_ROOT=/home/ubuntu/verium-master

# install dependencies
sudo apt-get update
sudo apt-get install -y unzip gcc g++ make automake supervisor
sudo apt-get install -y libcurl-ocaml-dev libssl-dev libgmp3-dev

# download and build
cd /home/ubuntu
wget https://github.com/veriumproject/verium/archive/master.zip
unzip master.zip
cd verium-master/
tar -xzvf cpuminer-opt-3.6.7.tar.gz
cd cpuminer-opt-3.6.7
./autogen.sh
CFLAGS="-O3 -march=native -Wall" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl
make
cp ../run.sh run.sh
chmod +x run.sh

# supervisor
cd ..
touch "$APP_ROOT/log.log"
sudo cp verium.conf /etc/supervisor/conf.d/verium.conf
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl restart all
