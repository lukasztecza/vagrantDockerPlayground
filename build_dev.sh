#!/bin/bash
if [ "$(whoami)" != "vagrant" ]; then
   echo "Run this script from inside vagrant machine";exit;
fi

if [ ! -d network ]; then
    git clone https://github.com/lukasztecza/dockerNetwork.git network;
    cd network;
    docker build -t network .;
    cd ..;
fi

if [ ! -d rest-app ]; then
    git clone https://github.com/lukasztecza/dockerApp.git rest-app;
    cd rest-app;
    composer install;
    docker build -t rest-app .;
    cd ..;
fi

if [ ! -d web-server ]; then
    git clone https://github.com/lukasztecza/dockerWebServer.git web-server;
    cd web-server;
    docker build -t web-server;
    cd ..;
fi

echo "Apps are built.";
