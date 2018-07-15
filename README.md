# vagrantDockerPlayground
Environment for playing with docker

### Usage
- Clone this repo and run:
```
vagrant box add https://app.vagrantup.com/ubuntu/boxes/trusty64
```

- Start the machine
```
vagrant up
```

- Login to the machine and build apps
```
vagrant ssh
cd /app
bash build_dev.sh
```

- Initialize docker swarm and deploy apps
```
docker swarm init
bash deploy.sh
```

- Add to your `/etc/hosts`
```
127.0.0.1 www.rest-app.com
```

- Several dev urls should be available now
```
network (1x) docker visualizer under localhost:8080
rest-app (2x) under www.rest-app.com:8000
web-server (1x) sample asset under www.rest-app.com:8000/assets/blah.png
```

- If you go and see rest-app you will see that hostname indicates container id that was used
- You can play around and scale it up to 5 containers with
```
docker service scale <rest-app-service-here>=5
```
