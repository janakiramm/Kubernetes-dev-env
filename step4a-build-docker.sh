# Point the Docker CLI to the dev machine
eval $(docker-machine env dev)

# Pull Apache image from Docker Hub
docker pull httpd

# Run the image in detached mode with port 80 exposed
docker run -d --name myweb --hostname myweb -p 80:80  httpd

# Replace contents of default Apache landing page
docker exec myweb bash -c "echo 'Kubernetes Rocks' > '/usr/local/apache2/htdocs/index.html'"

# Commit the image tagging it with the local registry
docker commit myweb $REG_IP:80/myweb

# Push the image to the local registry
docker push $REG_IP:80/myweb
