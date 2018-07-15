#!/usr/bin/env bash
apt-get update

if [ ! -f /usr/bin/git ]; then
    apt-get install -y vim curl git
fi

if [ ! -f /usr/bin/docker ]; then
    cd /vagrant
    curl -L 'https://download.docker.com/linux/ubuntu/dists/trusty/pool/stable/amd64/docker-ce_18.03.1~ce-0~ubuntu_amd64.deb' -o docker.deb
    apt-get install -y libsystemd-journal0
    dpkg -i docker.deb
    rm docker.deb
    sudo usermod -a -G docker vagrant
fi

if [ ! -f /usr/bin/docker-compose ]; then
    curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose
    sudo chmod +x /usr/bin/docker-compose
fi

#todo build apps here
