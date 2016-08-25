# Create a Docker machine to host the registry
docker-machine create -d virtualbox registry

# Create a folder to mount the volumes
docker-machine ssh registry "mkdir ~/data"

# Point the Docker CLI to registry
eval $(docker-machine env registry)

# Pull and run the registry image
docker run -d -p 80:5000 --restart=always --name registry -v /home/docker/data:/var/lib/registry registry:2

# Grab the IP of the host for later use
REG_IP=`docker-machine ip registry`
