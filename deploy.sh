#!/bin/bash
if [ "$(whoami)" != "vagrant" ]; then
   echo "Run this script from inside vagrant machine";exit;
fi

if [ "$1" == "" ]; then
    echo "Please specify one of the stacks do deploy or type all to deploy everything";exit;
fi
deployed=0;

deploy_helper() {
    app_name=$1;
    current_contaners="$(docker container ls -a -q -f name=$app_name-stack -f status=running)";
    number_of_containers="$(echo echo $current_contaners | tr -cd " " | wc -c)";
    docker stack deploy -c $app_name/docker-compose.yml $app_name-stack;
    if [ "$number_of_containers" -gt 0 ]; then
        docker service scale $app_name-stack_$app_name=$((2 * $number_of_containers));
        docker container stop $current_contaners;
        docker service scale $app_name-stack_$app_name=$number_of_containers;
    fi
}

if [ "$1" == "all" ] || [ "$1" == "network" ]; then
    docker stack deploy -c network/docker-compose.yml network-stack;
    deployed=$((deployed + 1));
fi

if [ "$1" == "all" ] || [ "$1" == "rest-app" ]; then
    deploy_helper rest-app
    deployed=$((deployed + 1));
fi

if [ "$1" == "all" ] || [ "$1" == "web-server" ]; then
    deploy_helper web-server
    deployed=$((deployed + 1));
fi

echo "Deployed $deployed stacks.";
