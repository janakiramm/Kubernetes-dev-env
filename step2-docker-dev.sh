# Create a Docker machine for the dev environment
docker-machine create -d virtualbox dev

# Grab the IP of the registry host
REG_IP=`docker-machine ip registry`

# Update Docker engine configuration with the insecure registry
docker-machine ssh dev 'sudo sh -c "echo \"EXTRA_ARGS=\\\"--insecure-registry '$REG_IP':80\\\"\" >> /var/lib/boot2docker/profile"'

# Restart the machine to apply the configuration
docker-machine restart dev

# Point the Docker CLI to the dev machine
eval $(docker-machine env dev)

# Pull an image from Docker Hub
docker pull hello-world

# Tag the image with the local registry
docker tag hello-world $REG_IP:80/hello-world

# Push the image to the local registry
docker push $REG_IP:80/hello-world
