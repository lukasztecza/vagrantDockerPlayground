#!/usr/bin/env bash
apt-get update

if [ ! -f /usr/bin/git ]; then
    sudo add-apt-repository ppa:ondrej/php
    apt-get install -y vim curl git php7.2
fi

if [ ! -f /usr/bin/docker ]; then
    cd /app
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

if ! [ -L /usr/bin/composer ]; then
    curl -Ss https://getcomposer.org/installer | php
    mv composer.phar /usr/bin/composer
    chmod +x /usr/bin/composer
fi

echo "login to vagrant machine: vagrant ssh";
echo "initialize docker swarm: docker swarm init";
echo "deploy demo application: bash deploy.sh all";
